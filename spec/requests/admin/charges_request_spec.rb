 require 'rails_helper'

RSpec.describe "/charges", type: :request do
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
 
  let(:valid_attributes) { attributes_for(:charge) }
  let(:invalid_attributes) { attributes_for(:charge, charge: nil) }

  describe "GET /index" do
    it '成功した応答をレンダリング' do
      Charge.create! valid_attributes
      get admin_charges_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it '成功した応答をレンダリング' do
      charge = Charge.create! valid_attributes
      get admin_charge_url(charge)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it '成功した応答をレンダリング' do
      get new_admin_charge_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it '成功した応答をレンダリング' do
      charge = Charge.create! valid_attributes
      get edit_admin_charge_url(charge)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context '正常パラメータを入力' do
      it '新しい代引き手数料を作成' do
        expect {
          post admin_charges_url, params: { charge: valid_attributes }
        }.to change(Charge, :count).by(1)
      end

      it '新しい代引き手数料作成後のリダイレクト' do
        post admin_charges_url, params: { charge: valid_attributes }
        expect(response).to redirect_to(admin_charges_url)
      end
    end

    context '不正パラメータを入力' do
      it '新しい代引き手数料を作成できない' do
        expect {
          post admin_charges_url, params: { charge: invalid_attributes }
        }.to change(Charge, :count).by(0)
      end

      it 'newテンプレートでレンダリングして成功応答' do
        post admin_charges_url, params: { charge: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context '正常パラメータを入力' do
      let(:new_attributes) {
        {charge: 999}
      }

      it '要求された代引き手数料を更新' do
        charge = Charge.create! valid_attributes
        patch admin_charge_url(charge), params: { charge: new_attributes }
        charge.reload
        expect(charge.charge).to eq(999)
      end

      it '代引き手数料更新後のリダイレクト' do
        charge = Charge.create! valid_attributes
        patch admin_charge_url(charge), params: { charge: new_attributes }
        charge.reload
        expect(response).to redirect_to(admin_charges_url)
      end
    end

    context '不正パラメータを入力' do
      it 'editテンプレートでレンダリングして成功応答' do
        charge = Charge.create! valid_attributes
        patch admin_charge_url(charge), params: { charge: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it '要求された代引き手数料を削除' do
      charge = Charge.create! valid_attributes
      expect {
        delete admin_charge_url(charge)
      }.to change(Charge, :count).by(-1)
    end

    it '代引き手数料削除後のリダイレクト' do
      charge = Charge.create! valid_attributes
      delete admin_charge_url(charge)
      expect(response).to redirect_to(admin_charges_url)
    end
  end
end
