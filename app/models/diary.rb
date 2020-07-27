class Diary < ApplicationRecord
  validates :content, length: {maximum: 200}

  belongs_to :user
  has_many :comments
  has_many :goods
  has_many :gooded_users, through: :goods, source: :user

  include ToastrErrorsOutputter
  mount_uploader :picture, PictureUploader
end
