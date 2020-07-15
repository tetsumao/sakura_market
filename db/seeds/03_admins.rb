[
  {login_name: 'admin', password: 'admin', admin_name: '管理者', dspo: 1},
].each do |record|
  begin
    Admin.create!(record)
  rescue => e
    puts record
    puts e
    raise e
  end
end
