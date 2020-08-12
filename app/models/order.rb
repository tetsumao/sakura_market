class Order < ApplicationRecord
  enum order_status: {ordered: 0, processing: 1, sent: 2, canceled: 3}

  belongs_to :user
  belongs_to :delivery_period
  belongs_to :trader, optional: true

  has_many :order_items, dependent: :destroy, autosave: true
  has_many :order_shippings, dependent: :destroy, autosave: true
  has_many :coupons, dependent: :destroy, autosave: true
  has_many :stocks, dependent: :destroy, autosave: true

  validates :ship_zip, format: {with: /\A[0-9]{3}-[0-9]{4}\z/}
  validates :ship_address, presence: true
  validate :validate_stock
  validate :validate_user_card, if: :card_payment?
  validate :validate_order_status

  include ToastrErrorsOutputter

  def self.delivery_dates
    # 3営業日（営業日: 月-金）から14営業日まで
    date = Date.tomorrow
    if date.saturday?
      date += 2
    elsif date.sunday?
      date += 1
    end
    dates = []
    14.times do |day|
      dates << date if day >= 2 
      if date.friday?
        date += 3
      else
        date += 1
      end
    end
    dates
  end

  def apply_cart_items(cart_items, use_point = 0, with_charge = false)
    self.item_price = cart_items.item_price
    self.charge_price = with_charge ? Charge.from_price(self.item_price).charge : 0
    self.trader = cart_items.first.trader
    self.shipping_price = build_order_shippings(cart_items.quantity)
    # 消費税10%
    self.tax_price = ((self.item_price + self.charge_price + self.shipping_price) * 10 / 100).floor
    cart_items.each do |cart_item|
      self.order_items.build(
        item: cart_item.item,
        quantity: cart_item.quantity,
        item_name: cart_item.item.item_name,
        picture: cart_item.item.picture,
        price: cart_item.item.price
      )
      self.stocks.build(
        trader: self.trader,
        item: cart_item.item,
        stock_number: -cart_item.quantity
      )
    end
    # ※クーポンレコード生成前だとsumが効かないのでインスタンス変数に計算しておく
    @point_price = build_coupons(use_point)
  end

  def cancelable?
    self.ordered?
  end

  def cancel
    self.order_status = :canceled
    self.coupons.each{|coupon| coupon.mark_for_destruction}
    self.stocks.each{|stock| stock.mark_for_destruction}
    if self.stripe_invid.present?
      stripe_block('返金') do
        if valid?
          # 更新できるなら払い戻し
          refund = Stripe::Refund.create(charge: self.stripe_invid)
          puts "Stripe::Refund -> #{refund}"
          return save
        end
      end
    else
      save
    end
  end

  def point_price
    @point_price ||= self.coupons.sum(:point)
  end

  def total_price
    @total_price ||= (self.item_price + self.charge_price + self.shipping_price + self.tax_price)
  end

  def invoice_price
    self.total_price + self.point_price
  end

  def card_payment?
    (self.charge_price <= 0)
  end

  # 支払い(saveの代わり)
  def payment
    amount = self.invoice_price
    if card_payment? && amount > 0
      stripe_block('決済') do
        charge = Stripe::Charge.create(customer: self.user.stripe_cusid, amount: amount,
          description: "ユーザ: #{self.user_id} の支払い", currency: 'jpy')
        self.stripe_invid = charge.id
        puts "Stripe::Charge -> #{charge}"
        return save
      end
    else
      save
    end
  end

  private
    # 在庫確認
    def validate_stock
      self.stocks.each do |stock|
        if stock.invalid?
          errors.add(:base, "#{stock.item.item_name}の数量が販売元業者の在庫を超過しています")
        end
      end
    end

    # ユーザのカード確認
    def validate_user_card
      unless self.user.card.present?
        errors.add(:base, '代引きを選択するかカード情報を登録してください')
      end
    end

    # 注文済みの時のみキャンセル可能
    def validate_order_status
      if self.order_status_changed? && self.canceled? && self.order_status_was.to_sym != :ordered
        errors.add(:order_status, 'キャンセルできません')
      end
    end

    # 注文送料を生成して送料を返す
    def build_order_shippings(quantity)
      remain_quantity = quantity.to_i
      if remain_quantity > 0
        if self.trader.present? && self.trader.shippings.length > 0
          # 数量昇順のため最後が最大
          max_shipping = self.trader.shippings.last
          price = 0
          last_order_shipping = nil
          while remain_quantity > 0
            # できるだけ少額で数量の少ない箱におさめる(金額比較は総当たりではなく、全量が収まる箱と1段階少ない箱まで)
            use_shipping = nil
            box = 1
            if remain_quantity < max_shipping.quantity
              self.trader.shippings.each do |shipping|
                if remain_quantity <= shipping.quantity
                  if use_shipping.nil?
                    use_shipping = shipping
                  else
                    box = (remain_quantity - 1).div(use_shipping.quantity) + 1
                    if shipping.price <= (use_shipping.price * box)
                      use_shipping = shipping
                      box = 1
                    end
                  end
                  break
                else
                  use_shipping = shipping
                end
              end
              remain_quantity = 0
            else
              use_shipping = max_shipping
              remain_quantity -= use_shipping.quantity
            end
            # できるだけ箱の種類をまとめる
            if last_order_shipping.present? && last_order_shipping.shipping == use_shipping
              last_order_shipping.box += box
            else
              last_order_shipping = self.order_shippings.build(
                shipping: use_shipping,
                box: box,
                shipping_name: use_shipping.shipping_name,
                price: use_shipping.price
              )
            end
          end
        else
          # 送料テーブルが無い場合はデフォルトで5商品ごとに600円追加する
          self.order_shippings.build(
            box: (remain_quantity - 1).div(5) + 1,
            shipping_name: '既定の箱',
            price: 600
          )
        end
        self.order_shippings.inject(0){|s, order_shipping| s + order_shipping.price * order_shipping.box}
      else
        0
      end
    end

    # クーポンを生成してポイント価格を返す
    def build_coupons(use_point)
      sum_price = 0
      if use_point > 0
        remain_use_point = [use_point, self.total_price].min
        # 未使用のクーポンコードのポイント使用
        self.user.coupons.usable_coupon_point_hashs.each do |coupon_point_hash|
          coupon_point = coupon_point_hash[:coupon_point].to_i
          point = -[remain_use_point, coupon_point].min
          remain_use_point += point
          self.coupons.build(
            user: self.user,
            coupon_code: coupon_point_hash[:coupon_code],
            admin_id: coupon_point_hash[:admin_id],
            point: point
          )
          sum_price += point
          break if remain_use_point <= 0
        end
      end
      sum_price
    end

    def stripe_block(name, &block)
      begin
        block.call
      rescue Stripe::CardError => e
        errors.add(:base, "#{name}でエラーが発生しました。#{e.message}")
      rescue Stripe::InvalidRequestError => e
        errors.add(:base, "#{name}(stripe)でエラーが発生しました（InvalidRequestError）#{e.message}")
      rescue Stripe::AuthenticationError => e
        errors.add(:base, "#{name}(stripe)でエラーが発生しました（AuthenticationError）#{e.message}")
      rescue Stripe::APIConnectionError => e
        errors.add(:base, "#{name}(stripe)でエラーが発生しました（APIConnectionError）#{e.message}")
      rescue Stripe::StripeError => e
        errors.add(:base, "#{name}(stripe)でエラーが発生しました（StripeError）#{e.message}")
      end
      false
    end
end
