class Charge < ApplicationRecord
  validates :charge, numericality: {only_integer: true, greater_than_or_equal_to: 0}

  scope :default_order, -> {order(:price_from, :price_to)}
  scope :from_price, -> (price) {where('(price_from IS NULL OR price_from >= :price) AND (price_to IS NULL OR price_to < :price)', price: price).first}
end
