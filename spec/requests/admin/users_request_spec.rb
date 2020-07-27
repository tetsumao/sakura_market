require 'rails_helper'

RSpec.describe "Admin::Users", type: :request do
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

  let(:valid_attributes) { attributes_for(:user) }
  let(:invalid_attributes) { attributes_for(:user, email: 'aaa') }

  describe "GET /index" do
    it '成功した応答をレンダリング' do
      User.create! valid_attributes
      get admin_users_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it '成功した応答をレンダリング' do
      user = User.create! valid_attributes
      get admin_user_url(user)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it '成功した応答をレンダリング' do
      user = User.create! valid_attributes
      get edit_admin_user_url(user)
      expect(response).to be_successful
    end
  end

  describe "PATCH /update" do
    context '正常パラメータを入力' do
      let(:new_attributes) {
        {email: 'abc@example.com'}
      }

      it "updates the requested user" do
        user = User.create! valid_attributes
        patch admin_user_url(user), params: { user: new_attributes }
        user.reload
        expect(user.email).to eq('abc@example.com')
      end

      it "redirects to the user" do
        user = User.create! valid_attributes
        patch admin_user_url(user), params: { user: new_attributes }
        user.reload
        expect(response).to redirect_to(admin_users_url)
      end
    end

    context '不正パラメータを入力' do
      it 'editテンプレートでレンダリングして成功応答' do
        user = User.create! valid_attributes
        patch admin_user_url(user), params: { user: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested user" do
      user = User.create! valid_attributes
      expect {
        delete admin_user_url(user)
      }.to change(User, :count).by(-1)
    end

    it "redirects to the users list" do
      user = User.create! valid_attributes
      delete admin_user_url(user)
      expect(response).to redirect_to(admin_users_url)
    end
  end
end
