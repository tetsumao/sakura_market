require 'rails_helper'

RSpec.describe "Trader::Sessions", type: :request do

  let(:valid_attributes) { attributes_for(:trader) }

  describe "GET /new" do
    it "ログイン画面のレスポンス" do
      get trader_login_path
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context '正常パラメータを入力' do
      it "業者ログイン" do
        trader = Trader.create! valid_attributes
        post trader_session_url, params: { trader_login_form: {email: trader.email, password: 'password'} }
        expect(session[:trader_id]).to eq(trader.id)
      end

      it "業者ログイン後のリダイレクト" do
        trader = Trader.create! valid_attributes
        post trader_session_url, params: { trader_login_form: {email: trader.email, password: 'password'} }
        expect(response).to redirect_to(trader_root_url)
      end
    end

    context '不正パラメータを入力' do
      it "業者ログイン失敗" do
        trader = Trader.create! valid_attributes
        post trader_session_url, params: { trader_login_form: {email: trader.email, password: 'password1'} }
        expect(session[:trader_id]).to eq(nil)
      end

      it "業者ログイン失敗後のリダイレクト" do
        trader = Trader.create! valid_attributes
        post trader_session_url, params: { trader_login_form: {email: trader.email, password: 'password1'} }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "業者ログアウト" do
      trader = Trader.create! valid_attributes
      post trader_session_url, params: { trader_login_form: {email: trader.email, password: 'password'} }
      delete trader_session_url
      expect(session[:trader_id]).to eq(nil)
    end

    it "業者ログアウト後のリダイレクト" do
      trader = Trader.create! valid_attributes
      post trader_session_url, params: { trader_login_form: {email: trader.email, password: 'password'} }
      delete trader_session_url
      expect(response).to redirect_to(trader_root_url)
    end
  end
end
