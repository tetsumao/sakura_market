FactoryBot.define do
  factory :diary do
    sequence(:content) { |n| format('%0200d', n) }
    picture{ nil }
  end
end
