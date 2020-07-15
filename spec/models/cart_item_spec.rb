require 'rails_helper'

RSpec.describe CartItem, type: :model do
  describe 'バリデーション' do
    it '重複する商品IDとユーザIDの組み合わせは無効' do
      item = create(:item)
      user = create(:user)
      cart_item1 = CartItem.create!(item_id: item.id, user_id: user.id, quantity: 1)
      cart_item2 = CartItem.new(item_id: item.id, user_id: user.id, quantity: 1)
      expect(cart_item2).not_to be_valid
    end

    it '数量が0以下は無効' do
      item = create(:item)
      user = create(:user)
      cart_item = CartItem.new(item_id: item.id, user_id: user.id, quantity: -1)
      expect(cart_item).not_to be_valid
    end

    it '送料は5商品で600円' do
      item = create(:item)
      user = create(:user)
      cart_item = CartItem.create!(item_id: item.id, user_id: user.id, quantity: 5)
      expect(CartItem.shipping_price).to eq(600)
    end
    it '送料は6商品で1200円' do
      item = create(:item)
      user = create(:user)
      cart_item = CartItem.create!(item_id: item.id, user_id: user.id, quantity: 6)
      expect(CartItem.shipping_price).to eq(1200)
    end
  end
end
