FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'password' }
    sequence(:user_name) { |n| "ユーザ#{n}" }
    sequence(:zip) { |n| format('%03d-%04d', 700 + n, n * 3) }
    sequence(:address) { |n| "住所#{n}" }
  end
end
