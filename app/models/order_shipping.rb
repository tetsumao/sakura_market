class OrderShipping < ApplicationRecord
  validates :box, numericality: { only_integer: true, greater_than: 0 }
  validates :price, numericality: {only_integer: true, greater_than_or_equal_to: 0}

  belongs_to :order, optional: true
  belongs_to :shipping, optional: true
end
