[
  {hour_from: 8, hour_to: 12},
  {hour_from: 12, hour_to: 14},
  {hour_from: 14, hour_to: 16},
  {hour_from: 16, hour_to: 18},
  {hour_from: 18, hour_to: 20},
  {hour_from: 20, hour_to: 21},
].each do |record|
  begin
    DeliveryPeriod.create!(record)
  rescue => e
    puts record
    puts e
    raise e
  end
end
