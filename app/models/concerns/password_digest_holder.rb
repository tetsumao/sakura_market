module PasswordDigestHolder
  extend ActiveSupport::Concern

  included do
    validates :password_digest, presence: true
  end
  
  def password=(raw_password)
    if raw_password.kind_of?(String) && raw_password.present?
      self.password_digest = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.password_digest = nil
    end
  end
end
