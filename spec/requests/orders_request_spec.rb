 require 'rails_helper'

RSpec.describe "/orders", type: :request do
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
  let(:valid_attributes) {
    {
      delivery_date: Date.today,
      delivery_period_id: delivery_period.id,
      ship_zip: '777-7777',
      ship_address: 'YYYY'
    }
  }
  let(:invalid_attributes) {
    {
      delivery_date: Date.today,
      delivery_period_id: delivery_period.id,
      ship_zip: '7777777',
      ship_address: 'YYYY'
    }
  }

  describe "GET /index" do
    it '成功した応答をレンダリング' do
      Order.create! full_valid_attributes
      get orders_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it '成功した応答をレンダリング' do
      order = Order.create! full_valid_attributes
      get order_url(order)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it '成功した応答をレンダリング' do
      trader.stocks.create!(item: item, stock_number: 1)
      user.cart_items.create!(item: item, trader: trader, quantity: 1)
      Charge.create!(charge: 100)
      get new_order_url
      expect(response).to be_successful
    end
  end

  describe "POST /confirm" do
    context '正常パラメータを入力' do
      it "新しい注文の確認(パラメータ正常)" do
        trader.stocks.create!(item: item, stock_number: 1)
        user.cart_items.create!(item: item, trader: trader, quantity: 1)
        Charge.create!(charge: 100)
        expect {
          post confirm_orders_url, params: { order: valid_attributes }
        }.to change(Order, :count).by(0)
      end

      it '成功した応答をレンダリング' do
        trader.stocks.create!(item: item, stock_number: 1)
        user.cart_items.create!(item: item, trader: trader, quantity: 1)
        Charge.create!(charge: 100)
        post confirm_orders_url, params: { order: valid_attributes }
        expect(response).to be_successful
      end
    end

    context '不正パラメータを入力' do
      it "新しい注文の確認(パラメータ異常)" do
        trader.stocks.create!(item: item, stock_number: 1)
        user.cart_items.create!(item: item, trader: trader, quantity: 1)
        Charge.create!(charge: 100)
        expect {
          post confirm_orders_url, params: { order: invalid_attributes }
        }.to change(Order, :count).by(0)
      end

      it '成功した応答をレンダリング' do
        trader.stocks.create!(item: item, stock_number: 1)
        user.cart_items.create!(item: item, trader: trader, quantity: 1)
        Charge.create!(charge: 100)
        post confirm_orders_url, params: { order: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "POST /create" do
    context '正常パラメータを入力' do
      it '新しい注文を作成' do
        trader.stocks.create!(item: item, stock_number: 1)
        user.cart_items.create!(item: item, trader: trader, quantity: 1)
        Charge.create!(charge: 100)
        expect {
          post orders_url, params: { order: valid_attributes }
        }.to change(Order, :count).by(1)
      end

      it '新しい注文作成後のリダイレクト' do
        trader.stocks.create!(item: item, stock_number: 1)
        user.cart_items.create!(item: item, trader: trader, quantity: 1)
        Charge.create!(charge: 100)
        post orders_url, params: { order: valid_attributes }
        expect(response).to redirect_to(order_url(Order.last))
      end
    end

    context '不正パラメータを入力' do
      it '新しい注文を作成できない' do
        trader.stocks.create!(item: item, stock_number: 1)
        user.cart_items.create!(item: item, trader: trader, quantity: 1)
        Charge.create!(charge: 100)
        expect {
          post orders_url, params: { order: invalid_attributes }
        }.to change(Order, :count).by(0)
      end

      it 'newテンプレートでレンダリングして成功応答' do
        trader.stocks.create!(item: item, stock_number: 1)
        user.cart_items.create!(item: item, trader: trader, quantity: 1)
        Charge.create!(charge: 100)
        post orders_url, params: { order: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end
end
