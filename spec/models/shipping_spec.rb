require 'rails_helper'

RSpec.describe Shipping, type: :model do
  describe 'バリデーション' do
    it '正常' do
      trader = create(:trader)
      shipping = build(:shipping, trader_id: trader.id)
      expect(shipping).to be_valid
    end
    it '数量が0は無効' do
      trader = create(:trader)
      shipping = build(:shipping, trader_id: trader.id, quantity: 0)
      expect(shipping).not_to be_valid
    end
    it '数量がマイナスは無効' do
      trader = create(:trader)
      shipping = build(:shipping, trader_id: trader.id, quantity: -2)
      expect(shipping).not_to be_valid
    end
  end
end
