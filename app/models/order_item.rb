class OrderItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :item

  mount_uploader :picture, PictureUploader
end
