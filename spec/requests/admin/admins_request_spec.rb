require 'rails_helper'

RSpec.describe "/admin/admins", type: :request do
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

  let(:valid_attributes) { attributes_for(:admin) }
  let(:invalid_attributes) { attributes_for(:admin, login_name: 'login.name') }

  describe "GET /index" do
    it '成功した応答をレンダリング' do
      get admin_admins_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it '成功した応答をレンダリング' do
      get admin_admin_url(admin)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it '成功した応答をレンダリング' do
      get new_admin_admin_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it '成功した応答をレンダリング' do
      get edit_admin_admin_url(admin)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context '正常パラメータを入力' do
      it '新しい管理者を作成' do
        expect {
          post admin_admins_url, params: { admin: valid_attributes }
        }.to change(Admin, :count).by(1)
      end

      it '新しい管理者作成後のリダイレクト' do
        post admin_admins_url, params: { admin: valid_attributes }
        expect(response).to redirect_to(admin_admins_url)
      end
    end

    context '不正パラメータを入力' do
      it "does not create a new Admin" do
        expect {
          post admin_admins_url, params: { admin: invalid_attributes }
        }.to change(Admin, :count).by(0)
      end

      it 'newテンプレートでレンダリングして成功応答' do
        post admin_admins_url, params: { admin: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context '正常パラメータを入力' do
      let(:new_attributes) {
        {login_name: 'loglog'}
      }
      it "updates the requested admin" do
        patch admin_admin_url(admin), params: { admin: new_attributes }
        admin.reload
        expect(admin.login_name).to eq('loglog')
      end

      it "redirects to the admin" do
        patch admin_admin_url(admin), params: { admin: new_attributes }
        admin.reload
        expect(response).to redirect_to(admin_admins_url)
      end
    end

    context '不正パラメータを入力' do
      it 'editテンプレートでレンダリングして成功応答' do
        patch admin_admin_url(admin), params: { admin: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested admin" do
      expect {
        delete admin_admin_url(admin)
      }.to change(Admin, :count).by(-1)
    end

    it "redirects to the admins list" do
      delete admin_admin_url(admin)
      expect(response).to redirect_to(admin_admins_url)
    end
  end
end
