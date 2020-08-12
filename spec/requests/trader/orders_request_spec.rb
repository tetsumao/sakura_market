require 'rails_helper'

RSpec.describe "Trader::Orders", type: :request do
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
  let(:user) { create(:user) }
  let(:item) { create(:item) }
  let(:delivery_period) { create(:delivery_period) }

  let(:full_valid_attributes) {
    {
      user_id: user.id,
      trader_id: trader.id,
      delivery_date: Date.today,
      delivery_period_id: delivery_period.id,
      item_price: item.price,
      charge_price: 100,
      shipping_price: 200,
      tax_price: 10,
      ship_zip: '777-7777',
      ship_address: 'YYYY'
    }
  }

  describe "GET /index" do
    it '成功した応答をレンダリング' do
      Order.create! full_valid_attributes
      get trader_orders_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it '成功した応答をレンダリング' do
      order = Order.create! full_valid_attributes
      get trader_order_url(order)
      expect(response).to be_successful
    end
  end

  describe "PATCH /update" do
    context '正常パラメータを入力' do
      it '注文ステータスを更新' do
        order = Order.create! full_valid_attributes
        patch trader_order_url(order), params: { order: { order_status: :processing } }
        order.reload
        expect(order.order_status.to_sym).to eq(:processing)
      end

      it '注文ステータス更新後のリダイレクト' do
        order = Order.create! full_valid_attributes
        patch trader_order_url(order), params: { order: { order_status: :processing } }
        order.reload
        expect(response).to redirect_to(trader_order_url(order))
      end
    end

    context '不正パラメータを入力' do
      it 'キャンセル不可状態でキャンセル' do
        order = Order.create! full_valid_attributes
        order.update(order_status: :processing)
        patch trader_order_url(order), params: { order: { order_status: :canceled } }
        order.reload
        expect(order.order_status.to_sym).to eq(:processing)
      end
    end
  end
end
