FactoryBot.define do
  factory :coupon do
    sequence(:point) { |n| n * 1000 }
  end
end
