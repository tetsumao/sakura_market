require 'rails_helper'

RSpec.describe "Items", type: :request do
  let(:valid_attributes) { attributes_for(:item) }

  describe "GET /index" do
    it "renders a successful response" do
      Item.create! valid_attributes
      get items_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      item = Item.create! valid_attributes
      get item_url(item)
      expect(response).to be_successful
    end
  end
end
