class Stock < ApplicationRecord
  belongs_to :trader
  belongs_to :item
  belongs_to :order, optional: true

  validates :stock_number, numericality: {only_integer: true, other_than: 0}
  validate :validate_stock_number

  scope :updatable, -> {where(order_id: nil).where(arel_table[:created_at].gt(last_ordered_created_at))}
  scope :default_order, -> {order(updated_at: :desc)}

  def self.item_id_stock_number_hash
    joins(:item).group('items.id').order('MIN(items.dspo)').sum(:stock_number)
  end

  def self.last_ordered_created_at
    where.not(order_id: nil).maximum(:created_at) || Time.at(0)
  end

  private
    def validate_stock_number
      sn = self.trader.item_stock_number(self.item_id)
      sn -= self.stock_number_in_database.to_i unless self.new_record?
      if (sn + self.stock_number) < 0
        errors.add(:stock_number, "は総量をマイナスにできません。#{-sn}以上を指定してください")
      end
    end
end
