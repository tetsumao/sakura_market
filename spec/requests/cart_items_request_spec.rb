 require 'rails_helper'

RSpec.describe "/cart_items", type: :request do
  # ユーザログイン
  before do
    post user_session_url,
      params: {
        user: {
          email: user.email,
          password: 'password',
          remember_me: '0'
        }
      }
  end
  let(:user) { create(:user) }
  let(:item) { create(:item) }
  
  let(:valid_attributes) { {user_id: user.id, item_id: item.id, quantity: 1} }
  let(:invalid_attributes) { {user_id: user.id, item_id: item.id, quantity: 0} }

  describe "GET /index" do
    it "renders a successful response" do
      CartItem.create! valid_attributes
      get cart_items_url
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new CartItem" do
        expect {
          post cart_items_url, params: { cart_item: valid_attributes }
        }.to change(CartItem, :count).by(1)
      end

      it "redirects to the created cart_item" do
        post cart_items_url, params: { cart_item: valid_attributes }
        expect(response).to redirect_to(items_path)
      end
    end

    context "with invalid parameters" do
      it "does not create a new CartItem" do
        expect {
          post cart_items_url, params: { cart_item: invalid_attributes }
        }.to change(CartItem, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post cart_items_url, params: { cart_item: invalid_attributes }
        expect(response).to redirect_to(item_path(item))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      it "updates the requested cart_item" do
        cart_item = CartItem.create! valid_attributes
        quantity = cart_item.quantity + 1
        patch cart_item_url(cart_item), params: { cart_item: { quantity: quantity } }
        cart_item.reload
        expect(cart_item.quantity).to eq(quantity)
      end

      it "redirects to the cart_item" do
        cart_item = CartItem.create! valid_attributes
        quantity = cart_item.quantity + 1
        patch cart_item_url(cart_item), params: { cart_item: { quantity: quantity } }
        cart_item.reload
        expect(response).to redirect_to(cart_items_url)
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        cart_item = CartItem.create! valid_attributes
        patch cart_item_url(cart_item), params: { cart_item: { quantity: 0 } }
        expect(response).to redirect_to(cart_items_url)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested cart_item" do
      cart_item = CartItem.create! valid_attributes
      expect {
        delete cart_item_url(cart_item)
      }.to change(CartItem, :count).by(-1)
    end

    it "redirects to the cart_items list" do
      cart_item = CartItem.create! valid_attributes
      delete cart_item_url(cart_item)
      expect(response).to redirect_to(cart_items_url)
    end
  end
end
