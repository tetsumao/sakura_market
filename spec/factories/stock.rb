FactoryBot.define do
  factory :stock do
    sequence(:stock_number) { |n| n * 10 }
  end
end
