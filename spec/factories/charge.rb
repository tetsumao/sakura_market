FactoryBot.define do
  factory :charge do
    sequence(:price_from) { |n| n * 1000 }
    sequence(:price_to) { |n| (n + 1) * 1000 }
    sequence(:charge) { |n| n * 10 }
  end
end
