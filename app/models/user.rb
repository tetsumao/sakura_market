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

  validates :email, presence: true, 'valid_email_2/email': true, uniqueness: true
  validates :user_name, :nickname, format: {
    with: /\A[0-9０-９\p{han}\p{Latin}\p{hiragana}\p{katakana}\u{30fc}\p{alpha}\p{blank}]+\z/
  }
  validates :zip, format: {with: /\A[0-9]{3}-[0-9]{4}\z/}, allow_blank: true

  mount_uploader :picture, PictureUploader

  def gooding_diary?(diary)
    self.gooded_diaries.include?(diary)
  end

  def coupon_point
    @coupon_point ||= self.coupons.sum(:point)
  end

  # Stripeのカード情報
  def card
    if stripe_customer.present? && stripe_customer.sources.total_count > 0
      @card ||= stripe_customer.sources.data[0]
    else
      nil
    end
  end

  def card_display
    "#{self.card.brand} **** **** **** #{self.card.last4}　有効期限：#{self.card.exp_month}/#{self.card.exp_year}"
  end

  # Stripeのカード登録 戻り値：true/false
  def register_card(stripe_token)
    attribtes = { email: self.email, source: stripe_token }
    if stripe_customer.present?
      @stripe_customer = Stripe::Customer.update(stripe_customer.id, attribtes)
      @stripe_customer.id.present?
    else
      @stripe_customer = Stripe::Customer.create(attribtes)
      if @stripe_customer.id.present?
        update(stripe_cusid: @stripe_customer.id)
      else
        false
      end
    end
  end

  # Stripのカード削除 戻り値：削除数、-1は失敗
  def delete_card
    if stripe_customer.present?
      num = 0
      stripe_customer.sources.data.each do |card|
        if Stripe::Customer.delete_source(stripe_customer.id, card.id).deleted
          num += 1
        else
          return -1
        end
      end
      num
    else
      0
    end
  end

  private
    def stripe_customer
      @stripe_customer ||= (self.stripe_cusid.present? ? Stripe::Customer.retrieve(self.stripe_cusid) : '')
    end
end
