require 'rails_helper'

RSpec.describe "Items", type: :request do
  let(:trader) { create(:trader) }

  let(:valid_attributes) { attributes_for(:item) }

  describe "GET /index" do
    it '成功した応答をレンダリング' do
      item = Item.create! valid_attributes
      Stock.create(trader: trader, item: item, stock_number: 1)
      get items_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it '成功した応答をレンダリング' do
      item = Item.create! valid_attributes
      Stock.create(trader: trader, item: item, stock_number: 1)
      get item_url(item, trader_id: trader.id)
      expect(response).to be_successful
    end
  end
end
