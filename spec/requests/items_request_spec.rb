require 'rails_helper'

RSpec.describe "Items", type: :request do
  let(:valid_attributes) { attributes_for(:item) }

  describe "GET /index" do
    it '成功した応答をレンダリング' do
      Item.create! valid_attributes
      get items_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it '成功した応答をレンダリング' do
      item = Item.create! valid_attributes
      get item_url(item)
      expect(response).to be_successful
    end
  end
end
