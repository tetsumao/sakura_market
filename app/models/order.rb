class Order < ApplicationRecord
  belongs_to :user
  belongs_to :delivery_period

  has_many :order_items, dependent: :destroy, autosave: true
  has_many :coupons, dependent: :destroy, autosave: true

  validates :ship_zip, format: {with: /\A[0-9]{3}-[0-9]{4}\z/}
  validates :ship_address, presence: true

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

  def apply_cart_items(cart_items, use_point = 0)
    self.item_price = cart_items.item_price
    self.charge_price = Charge.from_price(self.item_price).charge
    self.shipping_price = cart_items.shipping_price
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
    end
    # ※クーポンレコード生成前だとsumが効かないのでインスタンス変数に計算しておく
    @point_price = 0
    if use_point > 0
      remain_use_point = [use_point, self.total_price].min
      # 未使用のクーポンコードのポイント使用
      self.user.coupons.group(:coupon_code, :admin_id).select('coupon_code, admin_id, SUM(point) AS coupon_point, MIN(created_at) AS created_at').having('SUM(point) > 0').order('created_at ASC').each do |coupon|
        coupon_point = coupon[:coupon_point].to_i
        point = -[remain_use_point, coupon_point].min
        remain_use_point += point
        self.coupons.build(user: self.user, coupon_code: coupon[:coupon_code], admin_id: coupon[:admin_id], point: point)
        @point_price += point
        break if remain_use_point <= 0
      end
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
end
