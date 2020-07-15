 require 'rails_helper'

RSpec.describe "/items", type: :request do
  # 管理者ログイン
  before do
    post admin_session_url,
      params: {
        admin_login_form: {
          login_name: admin.login_name,
          password: 'password'
        }
      }
  end
  let(:admin) { create(:admin) }

  let(:valid_attributes) { attributes_for(:item) }
  let(:invalid_attributes) { attributes_for(:item, price: nil) }

  describe "GET /index" do
    it "renders a successful response" do
      Item.create! valid_attributes
      get admin_items_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      item = Item.create! valid_attributes
      get admin_item_url(item)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_admin_item_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      item = Item.create! valid_attributes
      get edit_admin_item_url(item)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Item" do
        expect {
          post admin_items_url, params: { item: valid_attributes }
        }.to change(Item, :count).by(1)
      end

      it "redirects to the created item" do
        post admin_items_url, params: { item: valid_attributes }
        expect(response).to redirect_to(admin_items_url)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Item" do
        expect {
          post admin_items_url, params: { item: invalid_attributes }
        }.to change(Item, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post admin_items_url, params: { item: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {price: 9999999}
      }

      it "updates the requested item" do
        item = Item.create! valid_attributes
        patch admin_item_url(item), params: { item: new_attributes }
        item.reload
        expect(item.price).to eq(9999999)
      end

      it "redirects to the item" do
        item = Item.create! valid_attributes
        patch admin_item_url(item), params: { item: new_attributes }
        item.reload
        expect(response).to redirect_to(admin_items_url)
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        item = Item.create! valid_attributes
        patch admin_item_url(item), params: { item: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested item" do
      item = Item.create! valid_attributes
      expect {
        delete admin_item_url(item)
      }.to change(Item, :count).by(-1)
    end

    it "redirects to the items list" do
      item = Item.create! valid_attributes
      delete admin_item_url(item)
      expect(response).to redirect_to(admin_items_url)
    end
  end
end