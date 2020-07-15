class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  
  has_many :cart_items, ->{order(created_at: :desc)}, dependent: :destroy
  has_many :orders, ->{order(created_at: :desc)}, dependent: :destroy
  
  validates :email, presence: true, 'valid_email_2/email': true
  validates :user_name, format: {
    with: /\A[0-9０-９\p{han}\p{Latin}\p{hiragana}\p{katakana}\u{30fc}\p{alpha}\p{blank}]+\z/
  }
end
