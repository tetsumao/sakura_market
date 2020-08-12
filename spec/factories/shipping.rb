FactoryBot.define do
  factory :shipping do
    sequence(:shipping_name) { |n| "箱#{n}" }
    sequence(:quantity) { |n| n * 10 }
    sequence(:price) { |n| n * 100 }
  end
end
