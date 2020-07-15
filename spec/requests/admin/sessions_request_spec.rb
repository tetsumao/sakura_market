require 'rails_helper'

RSpec.describe "Admin::Sessions", type: :request do

  let(:valid_attributes) { attributes_for(:admin) }

  describe "GET /new" do
    it "ログイン画面のレスポンス" do
      get admin_login_path
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "管理者ログイン" do
        admin = Admin.create! valid_attributes
        post admin_session_url, params: { admin_login_form: {login_name: admin.login_name, password: 'password'} }
        expect(session[:admin_id]).to eq(admin.id)
      end

      it "管理者ログイン後のリダイレクト" do
        admin = Admin.create! valid_attributes
        post admin_session_url, params: { admin_login_form: {login_name: admin.login_name, password: 'password'} }
        expect(response).to redirect_to(admin_root_url)
      end
    end

    context "with invalid parameters" do
      it "管理者ログイン失敗" do
        admin = Admin.create! valid_attributes
        post admin_session_url, params: { admin_login_form: {login_name: admin.login_name, password: 'password1'} }
        expect(session[:admin_id]).to eq(nil)
      end

      it "管理者ログイン失敗後のリダイレクト" do
        admin = Admin.create! valid_attributes
        post admin_session_url, params: { admin_login_form: {login_name: admin.login_name, password: 'password1'} }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "管理者ログアウト" do
      admin = Admin.create! valid_attributes
      post admin_session_url, params: { admin_login_form: {login_name: admin.login_name, password: 'password'} }
      delete admin_session_url
      expect(session[:admin_id]).to eq(nil)
    end

    it "管理者ログアウト後のリダイレクト" do
      admin = Admin.create! valid_attributes
      post admin_session_url, params: { admin_login_form: {login_name: admin.login_name, password: 'password'} }
      delete admin_session_url
      expect(response).to redirect_to(admin_root_url)
    end
  end
end
