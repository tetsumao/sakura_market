class Shipping < ApplicationRecord
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  
  belongs_to :trader
end
