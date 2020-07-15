class DeliveryPeriod < ApplicationRecord
  validates :hour_from, numericality: { only_integer: true, greater_than_or_equal_to: 8, less_than_or_equal_to: 21 }
  validates :hour_to, numericality: { only_integer: true, greater_than_or_equal_to: 8, less_than_or_equal_to: 21 }

  scope :default_order, -> {order(:hour_from, :hour_to)}

  def hour_from_s
    "#{self.hour_from}:00"
  end
  def hour_to_s
    "#{self.hour_to}:00"
  end

  def period_name
    "#{self.hour_from_s}～#{self.hour_to_s}"
  end
end
