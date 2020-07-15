class Item < ApplicationRecord
  validates :price, numericality: {only_integer: true, greater_than_or_equal_to: 0}

  mount_uploader :picture, PictureUploader

  has_many :cart_item, dependent: :destroy
  has_many :order_item, dependent: :destroy

  include DspoHolder

  scope :enabled, -> {where(disabled: false)}
end
