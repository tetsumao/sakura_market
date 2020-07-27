class Admin < ApplicationRecord
  has_many :coupons

  validates :login_name, uniqueness: true, presence: true, format: /\A[a-zA-Z0-9]+\z/, length: {maximum: 20}

  include DspoHolder
  
  def password=(raw_password)
    if raw_password.kind_of?(String)
      self.password_digest = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.password_digest = nil
    end
  end
end
