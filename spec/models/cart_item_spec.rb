require 'rails_helper'

RSpec.describe CartItem, type: :model do
  describe 'バリデーション' do
    it '正常' do
      item = create(:item)
      user = create(:user)
      trader = create(:trader)
      cart_item = CartItem.new(item_id: item.id, user_id: user.id, trader_id: trader.id, quantity: 1)
      expect(cart_item).to be_valid
    end

    it '重複する商品IDとユーザIDの組み合わせは無効' do
      item = create(:item)
      user = create(:user)
      trader = create(:trader)
      cart_item1 = CartItem.create!(item_id: item.id, user_id: user.id, trader_id: trader.id, quantity: 1)
      cart_item2 = CartItem.new(item_id: item.id, user_id: user.id, trader_id: trader.id, quantity: 1)
      expect(cart_item2).not_to be_valid
    end

    it '数量が0以下は無効' do
      item = create(:item)
      user = create(:user)
      trader = create(:trader)
      cart_item = CartItem.new(item_id: item.id, user_id: user.id, trader_id: trader.id, quantity: -1)
      expect(cart_item).not_to be_valid
    end

    it '複数の業者が混在は無効' do
      item1 = create(:item)
      item2 = create(:item)
      user = create(:user)
      trader1 = create(:trader)
      trader2 = create(:trader)
      cart_item1 = CartItem.create!(item_id: item1.id, user_id: user.id, trader_id: trader1.id, quantity: 1)
      cart_item2 = CartItem.new(item_id: item2.id, user_id: user.id, trader_id: trader2.id, quantity: 1)
      expect(cart_item2).not_to be_valid
    end
  end
end
