 require 'rails_helper'

RSpec.describe "/shippings", type: :request do
  # 業者ログイン
  before do
    post trader_session_url,
      params: {
        trader_login_form: {
          email: trader.email,
          password: 'password'
        }
      }
  end
  let(:trader) { create(:trader) }

  let(:valid_attributes) { attributes_for(:shipping, trader_id: trader.id) }
  let(:invalid_attributes) { attributes_for(:shipping, trader_id: trader.id, quantity: 0) }

  describe "GET /index" do
    it '成功した応答をレンダリング' do
      Shipping.create! valid_attributes
      get trader_shippings_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it '成功した応答をレンダリング' do
      shipping = Shipping.create! valid_attributes
      get trader_shipping_url(shipping)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it '成功した応答をレンダリング' do
      get new_trader_shipping_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it '成功した応答' do
      shipping = Shipping.create! valid_attributes
      get edit_trader_shipping_url(shipping)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context '正常パラメータを入力' do
      it '新しい送料を作成' do
        expect {
          post trader_shippings_url, params: { shipping: valid_attributes }
        }.to change(Shipping, :count).by(1)
      end

      it '新しい送料作成後のリダイレクト' do
        post trader_shippings_url, params: { shipping: valid_attributes }
        expect(response).to redirect_to(trader_shippings_url)
      end
    end

    context '不正パラメータを入力' do
      it '新しい送料を作成できない' do
        expect {
          post trader_shippings_url, params: { shipping: invalid_attributes }
        }.to change(Shipping, :count).by(0)
      end

      it '成功した応答をnewテンプレートからレンダリング' do
        post trader_shippings_url, params: { shipping: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context '正常パラメータを入力' do
      let(:new_attributes) {
        {quantity: 12}
      }

      it '要求された送料を更新' do
        shipping = Shipping.create! valid_attributes
        patch trader_shipping_url(shipping), params: { shipping: new_attributes }
        shipping.reload
        expect(shipping.quantity).to eq(12)
      end

      it '送料更新後のリダイレクト' do
        shipping = Shipping.create! valid_attributes
        patch trader_shipping_url(shipping), params: { shipping: new_attributes }
        shipping.reload
        expect(response).to redirect_to(trader_shippings_url)
      end
    end

    context '不正パラメータを入力' do
      it 'editテンプレートでレンダリングして成功応答' do
        shipping = Shipping.create! valid_attributes
        patch trader_shipping_url(shipping), params: { shipping: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it '要求された送料を削除' do
      shipping = Shipping.create! valid_attributes
      expect {
        delete trader_shipping_url(shipping)
      }.to change(Shipping, :count).by(-1)
    end

    it '送料削除後のリダイレクト' do
      shipping = Shipping.create! valid_attributes
      delete trader_shipping_url(shipping)
      expect(response).to redirect_to(trader_shippings_url)
    end
  end
end
