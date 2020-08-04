FactoryBot.define do
  factory :trader do
    sequence(:email) { |n| "trader#{n}@example.com" }
    password { 'password' }
    sequence(:trader_name) { |n| "業者#{n}" }
  end
end
