[
  {price_from: 0, price_to: 10000, charge: 300},
  {price_from: 10000, price_to: 30000, charge: 400},
  {price_from: 30000, price_to: 100000, charge: 600},
  {price_from: 100000, price_to: nil, charge: 1000},
].each do |record|
  begin
    Charge.create!(record)
  rescue => e
    puts record
    puts e
    raise e
  end
end
