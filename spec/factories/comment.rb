FactoryBot.define do
  factory :comment do
    sequence(:content) { |n| format('%0140d', n) }
  end
end
