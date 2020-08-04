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
  let(:trader) { create(:trader) }
  
  let(:valid_attributes) { {user_id: user.id, item_id: item.id, trader_id: trader.id, quantity: 1} }
  let(:invalid_attributes) { {user_id: user.id, item_id: item.id, trader_id: trader.id, quantity: 0} }

  describe "GET /index" do
    it '成功した応答をレンダリング' do
      CartItem.create! valid_attributes
      get cart_items_url
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context '正常パラメータを入力' do
      it '新しいショッピングカート作成' do
        expect {
          post cart_items_url, params: { cart_item: valid_attributes }
        }.to change(CartItem, :count).by(1)
      end

      it 'ショッピングカート作成後のリダイレクト' do
        post cart_items_url, params: { cart_item: valid_attributes }
        expect(response).to redirect_to(items_path)
      end
    end

    context '不正パラメータを入力' do
      it '新しいショッピングカートを作成できない' do
        expect {
          post cart_items_url, params: { cart_item: invalid_attributes }
        }.to change(CartItem, :count).by(0)
      end

      it 'newテンプレートでレンダリングして成功応答' do
        post cart_items_url, params: { cart_item: invalid_attributes }
        expect(response).to redirect_to(item_path(item, trader_id: trader.id))
      end
    end
  end

  describe "PATCH /update" do
    context '正常パラメータを入力' do
      it 'ショッピングカートを更新' do
        cart_item = CartItem.create! valid_attributes
        quantity = cart_item.quantity + 1
        patch cart_item_url(cart_item), params: { cart_item: { quantity: quantity } }
        cart_item.reload
        expect(cart_item.quantity).to eq(quantity)
      end

      it 'ショッピングカート更新後のリダイレクト' do
        cart_item = CartItem.create! valid_attributes
        quantity = cart_item.quantity + 1
        patch cart_item_url(cart_item), params: { cart_item: { quantity: quantity } }
        cart_item.reload
        expect(response).to redirect_to(cart_items_url)
      end
    end

    context '不正パラメータを入力' do
      it 'editテンプレートでレンダリングして成功応答' do
        cart_item = CartItem.create! valid_attributes
        patch cart_item_url(cart_item), params: { cart_item: { quantity: 0 } }
        expect(response).to redirect_to(cart_items_url)
      end
    end
  end

  describe "DELETE /destroy" do
    it '要求されたショッピングカートを削除する' do
      cart_item = CartItem.create! valid_attributes
      expect {
        delete cart_item_url(cart_item)
      }.to change(CartItem, :count).by(-1)
    end

    it 'ショッピングカート削除後のリダイレクト' do
      cart_item = CartItem.create! valid_attributes
      delete cart_item_url(cart_item)
      expect(response).to redirect_to(cart_items_url)
    end
  end
end
