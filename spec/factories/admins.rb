FactoryBot.define do
  factory :admin do
    sequence(:login_name) { |n| "login#{n}" }
    password { 'password' }
    sequence(:admin_name) { |n| "管理者#{n}" }
    sequence(:dspo) { |n| n }
  end
end
