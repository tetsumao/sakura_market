FactoryBot.define do
  factory :delivery_period do
    sequence(:hour_from) { |n| ((n * 2) % 12) + 8 }
    sequence(:hour_to) { |n| ((n * 2) % 12) + 9 }
  end
end
