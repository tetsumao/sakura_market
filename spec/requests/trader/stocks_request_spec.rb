 require 'rails_helper'

RSpec.describe "/stocks", type: :request do
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
  let(:item) { create(:item) }

  let(:valid_attributes) { attributes_for(:stock, trader_id: trader.id, item_id: item.id) }
  let(:invalid_attributes) { attributes_for(:stock, trader_id: trader.id, item_id: item.id, stock_number: 0) }

  describe "GET /index" do
    it '成功した応答をレンダリング' do
      Stock.create! valid_attributes
      get trader_stocks_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it '成功した応答をレンダリング' do
      stock = Stock.create! valid_attributes
      get trader_stock_url(stock)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it '成功した応答をレンダリング' do
      get new_trader_stock_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it '成功した応答' do
      stock = Stock.create! valid_attributes
      get edit_trader_stock_url(stock)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context '正常パラメータを入力' do
      it '新しい在庫を作成' do
        expect {
          post trader_stocks_url, params: { stock: valid_attributes }
        }.to change(Stock, :count).by(1)
      end

      it '新しい在庫作成後のリダイレクト' do
        post trader_stocks_url, params: { stock: valid_attributes }
        expect(response).to redirect_to(trader_stocks_url)
      end
    end

    context '不正パラメータを入力' do
      it '新しい在庫を作成できない' do
        expect {
          post trader_stocks_url, params: { stock: invalid_attributes }
        }.to change(Stock, :count).by(0)
      end

      it '成功した応答をnewテンプレートからレンダリング' do
        post trader_stocks_url, params: { stock: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context '正常パラメータを入力' do
      let(:new_attributes) {
        {stock_number: 12}
      }

      it '要求された在庫を更新' do
        stock = Stock.create! valid_attributes
        patch trader_stock_url(stock), params: { stock: new_attributes }
        stock.reload
        expect(stock.stock_number).to eq(12)
      end

      it '在庫更新後のリダイレクト' do
        stock = Stock.create! valid_attributes
        patch trader_stock_url(stock), params: { stock: new_attributes }
        stock.reload
        expect(response).to redirect_to(trader_stocks_url)
      end
    end

    context '不正パラメータを入力' do
      it 'editテンプレートでレンダリングして成功応答' do
        stock = Stock.create! valid_attributes
        patch trader_stock_url(stock), params: { stock: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it '要求された在庫を削除' do
      stock = Stock.create! valid_attributes
      expect {
        delete trader_stock_url(stock)
      }.to change(Stock, :count).by(-1)
    end

    it '在庫削除後のリダイレクト' do
      stock = Stock.create! valid_attributes
      delete trader_stock_url(stock)
      expect(response).to redirect_to(trader_stocks_url)
    end
  end
end
