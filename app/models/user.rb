class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  
  has_many :cart_items, ->{order(created_at: :desc)}, dependent: :destroy
  has_many :orders, ->{order(created_at: :desc)}, dependent: :destroy
  
  has_many :diaries, dependent: :destroy
  has_many :comments
  has_many :goods, dependent: :destroy
  has_many :gooded_diaries, through: :goods, source: :diary
  has_many :coupons

  validates :email, presence: true, 'valid_email_2/email': true
  validates :user_name, :nickname, format: {
    with: /\A[0-9０-９\p{han}\p{Latin}\p{hiragana}\p{katakana}\u{30fc}\p{alpha}\p{blank}]+\z/
  }
  
  mount_uploader :picture, PictureUploader

  def gooding_diary?(diary)
    self.gooded_diaries.include?(diary)
  end

  def coupon_point
    @coupon_point ||= self.coupons.sum(:point)
  end
end
