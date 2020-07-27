class Coupon < ApplicationRecord
  belongs_to :admin
  belongs_to :user, optional: true
  belongs_to :order, optional: true

  validates :coupon_code, format: /\A[a-zA-Z0-9]+\z/, length: {is: 12}
  validates :point, numericality: {only_integer: true, other_than: 0}

  include ToastrErrorsOutputter

  scope :default_order, -> {order(updated_at: :desc)}

  before_validation do
    if self.coupon_code.blank?
      begin 
        # 英数12桁
        self.coupon_code = SecureRandom.alphanumeric(12) 
      end while Coupon.exists?(coupon_code: self.coupon_code)
    end
  end

  def display_coupon_code
    self.coupon_code.scan(/.{1,4}/).join('-')
  end
end
