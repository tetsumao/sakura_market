class Admin < ApplicationRecord
  has_many :coupons

  validates :login_name, uniqueness: true, presence: true, format: /\A[a-zA-Z0-9]+\z/, length: {maximum: 20}, uniqueness: {case_sensitive: false}
  
  include DspoHolder
  include PasswordDigestHolder
end
