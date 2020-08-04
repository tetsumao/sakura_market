 require 'rails_helper'

RSpec.describe "/traders", type: :request do
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

  let(:valid_attributes) { attributes_for(:trader) }
  let(:invalid_attributes) { attributes_for(:trader, email: 'trader@@bbb.co') }

  describe "GET /index" do
    it '成功した応答をレンダリング' do
      Trader.create! valid_attributes
      get admin_traders_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it '成功した応答をレンダリング' do
      trader = Trader.create! valid_attributes
      get admin_trader_url(trader)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it '成功した応答をレンダリング' do
      get new_admin_trader_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it '成功した応答' do
      trader = Trader.create! valid_attributes
      get edit_admin_trader_url(trader)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context '正常パラメータを入力' do
      it '新しい業者を作成' do
        expect {
          post admin_traders_url, params: { trader: valid_attributes }
        }.to change(Trader, :count).by(1)
      end

      it '新しい業者作成後のリダイレクト' do
        post admin_traders_url, params: { trader: valid_attributes }
        expect(response).to redirect_to(admin_traders_url)
      end
    end

    context '不正パラメータを入力' do
      it '新しい業者を作成できない' do
        expect {
          post admin_traders_url, params: { trader: invalid_attributes }
        }.to change(Trader, :count).by(0)
      end

      it '成功した応答をnewテンプレートからレンダリング' do
        post admin_traders_url, params: { trader: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context '正常パラメータを入力' do
      let(:new_attributes) {
        {trader_name: '業者A'}
      }

      it '要求された業者を更新' do
        trader = Trader.create! valid_attributes
        patch admin_trader_url(trader), params: { trader: new_attributes }
        trader.reload
        expect(trader.trader_name).to eq('業者A')
      end

      it '業者更新後のリダイレクト' do
        trader = Trader.create! valid_attributes
        patch admin_trader_url(trader), params: { trader: new_attributes }
        trader.reload
        expect(response).to redirect_to(admin_traders_url)
      end
    end

    context '不正パラメータを入力' do
      it 'editテンプレートでレンダリングして成功応答' do
        trader = Trader.create! valid_attributes
        patch admin_trader_url(trader), params: { trader: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it '要求された業者を削除' do
      trader = Trader.create! valid_attributes
      expect {
        delete admin_trader_url(trader)
      }.to change(Trader, :count).by(-1)
    end

    it '業者削除後のリダイレクト' do
      trader = Trader.create! valid_attributes
      delete admin_trader_url(trader)
      expect(response).to redirect_to(admin_traders_url)
    end
  end
end
