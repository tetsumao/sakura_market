[
  {item_name: 'さくらんぼ', picture: open(Rails.root.join('db/fixtures/img1.jpg')), price: 500, description: 'おいしいさくらんぼです。', dspo: 1},
  {item_name: 'キャベツ', picture: open(Rails.root.join('db/fixtures/img2.jpg')), price: 600, description: 'とれたてのキャベツです。', dspo: 2},
  {item_name: 'だいこん', picture: open(Rails.root.join('db/fixtures/img3.jpg')), price: 300, description: '新鮮なだいこんです。', dspo: 3},
  {item_name: '白菜', picture: open(Rails.root.join('db/fixtures/img4.jpg')), price: 400, description: '大きな白菜です。', dspo: 4},
  {item_name: 'にら', picture: open(Rails.root.join('db/fixtures/img5.jpg')), price: 200, description: 'にらです。', dspo: 5},
  {item_name: 'メロン', picture: open(Rails.root.join('db/fixtures/img6.jpg')), price: 900, description: 'メロンはいかが？', dspo: 6},
  {item_name: 'しいたけ', picture: open(Rails.root.join('db/fixtures/img7.jpg')), price: 450, description: 'おいしいしいたけです。', dspo: 7},
].each do |record|
  begin
    Item.create!(record)
  rescue => e
    puts record
    puts e
    raise e
  end
end
