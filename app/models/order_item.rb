class OrderItem < ApplicationRecord
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :price, numericality: {only_integer: true, greater_than_or_equal_to: 0}

  belongs_to :order, optional: true
  belongs_to :item

  mount_uploader :picture, PictureUploader
end
