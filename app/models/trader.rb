class Trader < ApplicationRecord
  has_many :stocks
  has_many :orders, -> {order(created_at: :desc)}
  has_many :cart_items
  has_many :items, -> {distinct}, through: :stocks
  has_many :shippings, -> {order(:quantity)}, dependent: :destroy

  scope :default_order, -> {order(:id)}

  validates :email, presence: true, 'valid_email_2/email': true, uniqueness: {case_sensitive: false}
  validates :trader_name, format: {
    with: /\A[0-9０-９\p{han}\p{Latin}\p{hiragana}\p{katakana}\u{30fc}\p{alpha}\p{blank}]+\z/
  }

  include PasswordDigestHolder

  def item_stock_number(item_id)
    @item_id_stock_number_hash ||= self.stocks.item_id_stock_number_hash
    @item_id_stock_number_hash[item_id].to_i
  end

  def item_stock_number_selection(item_id)
    num = item_stock_number(item_id)
    # 最大30まで
    num = 30 if num > 30
    (num > 0) ? 1..num : [0]
  end
end
