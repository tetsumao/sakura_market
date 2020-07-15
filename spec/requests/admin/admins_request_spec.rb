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
    it "renders a successful response" do
      get admin_admins_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get admin_admin_url(admin)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_admin_admin_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      get edit_admin_admin_url(admin)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Admin" do
        expect {
          post admin_admins_url, params: { admin: valid_attributes }
        }.to change(Admin, :count).by(1)
      end

      it "redirects to the created admin" do
        post admin_admins_url, params: { admin: valid_attributes }
        expect(response).to redirect_to(admin_admins_url)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Admin" do
        expect {
          post admin_admins_url, params: { admin: invalid_attributes }
        }.to change(Admin, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post admin_admins_url, params: { admin: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
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

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
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
