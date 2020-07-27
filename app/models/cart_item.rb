class CartItem < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates :item_id, uniqueness: {scope: :user_id}
  validates :quantity, numericality: {greater_than: 0}

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
end
