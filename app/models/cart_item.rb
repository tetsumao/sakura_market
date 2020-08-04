class CartItem < ApplicationRecord
  belongs_to :user
  belongs_to :item
  belongs_to :trader, optional: true

  validates :item_id, uniqueness: {scope: :user_id}
  validates :quantity, numericality: {greater_than: 0}
  validate :one_trader

  include ToastrErrorsOutputter

  def self.item_price
    all.inject(0){|s, cart_item| s + cart_item.item.price * cart_item.quantity}
  end

  def self.quantity
    sum(:quantity)
  end

  def self.shipping_price
    # 送料は5商品ごとに600円追加する
    ((quantity - 1).div(5) + 1) * 600
  end

  private
    # 1種類の業者のみ
    def one_trader
      cart_item_first = self.user.cart_items.first
      if cart_item_first.present? && cart_item_first.trader_id != self.trader_id
        errors.add(:trader_id, '複数の業者の商品を追加できません')
      end 
    end
end
