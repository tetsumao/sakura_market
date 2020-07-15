FactoryBot.define do
  factory :order do
    delivery_date { Date.today }
    sequence(:item_price) { |n| n * 1000 }
    sequence(:charge_price) { |n| n * 100 }
    sequence(:shipping_price) { |n| n * 200 }
    sequence(:tax_price) { |n| n * 10 }
    ship_zip { '777-7777' }
    ship_address { 'YYYY' }
  end
end
