FactoryBot.define do
  factory :item do
    sequence(:item_name) { |n| "商品#{n}" }
    picture{ nil }
    sequence(:price) { |n| n * 100 }
    sequence(:description) { |n| "説明\n#{n}" }
    sequence(:disabled) { |n| (n.div(3) == 2) }
    sequence(:dspo) { |n| n }
  end
end
