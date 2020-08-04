require 'rails_helper'

RSpec.describe Stock, type: :model do
  describe 'バリデーション' do
    it '正常' do
      trader = create(:trader)
      item = create(:item)
      stock = build(:stock, trader_id: trader.id, item_id: item.id)
      expect(stock).to be_valid
    end
    it '総量がマイナスになる場合は無効' do
      trader = create(:trader)
      item = create(:item)
      create(:stock, trader_id: trader.id, item_id: item.id, stock_number: 2)
      stock = build(:stock, trader_id: trader.id, item_id: item.id, stock_number: -3)
      expect(stock).not_to be_valid
    end
    it '数量が0は無効' do
      trader = create(:trader)
      item = create(:item)
      stock = build(:stock, trader_id: trader.id, item_id: item.id, stock_number: 0)
      expect(stock).not_to be_valid
    end
  end
end
