 require 'rails_helper'

RSpec.describe "/delivery_periods", type: :request do
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
  
  let(:valid_attributes) { attributes_for(:delivery_period) }
  let(:invalid_attributes) { attributes_for(:delivery_period, hour_from: nil) }

  describe "GET /index" do
    it '成功した応答をレンダリング' do
      DeliveryPeriod.create! valid_attributes
      get admin_delivery_periods_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it '成功した応答をレンダリング' do
      delivery_period = DeliveryPeriod.create! valid_attributes
      get admin_delivery_period_url(delivery_period)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it '成功した応答をレンダリング' do
      get new_admin_delivery_period_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it '成功した応答をレンダリング' do
      delivery_period = DeliveryPeriod.create! valid_attributes
      get edit_admin_delivery_period_url(delivery_period)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context '正常パラメータを入力' do
      it '新しい配達時間帯を作成' do
        expect {
          post admin_delivery_periods_url, params: { delivery_period: valid_attributes }
        }.to change(DeliveryPeriod, :count).by(1)
      end

      it '新しい配達時間帯作成後のリダイレクト' do
        post admin_delivery_periods_url, params: { delivery_period: valid_attributes }
        expect(response).to redirect_to(admin_delivery_periods_url)
      end
    end

    context '不正パラメータを入力' do
      it '新しい配達時間帯を作成できない' do
        expect {
          post admin_delivery_periods_url, params: { delivery_period: invalid_attributes }
        }.to change(DeliveryPeriod, :count).by(0)
      end

      it '成功した応答をnewテンプレートからレンダリング' do
        post admin_delivery_periods_url, params: { delivery_period: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context '正常パラメータを入力' do
      let(:new_attributes) {
        {hour_to: 21}
      }

      it '要求された配達時間帯を更新' do
        delivery_period = DeliveryPeriod.create! valid_attributes
        patch admin_delivery_period_url(delivery_period), params: { delivery_period: new_attributes }
        delivery_period.reload
        expect(delivery_period.hour_to).to eq(21)
      end

      it '配達時間帯更新後のリダイレクト' do
        delivery_period = DeliveryPeriod.create! valid_attributes
        patch admin_delivery_period_url(delivery_period), params: { delivery_period: new_attributes }
        delivery_period.reload
        expect(response).to redirect_to(admin_delivery_periods_url)
      end
    end

    context '不正パラメータを入力' do
      it 'editテンプレートでレンダリングして成功応答' do
        delivery_period = DeliveryPeriod.create! valid_attributes
        patch admin_delivery_period_url(delivery_period), params: { delivery_period: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it '要求された配達時間帯を削除' do
      delivery_period = DeliveryPeriod.create! valid_attributes
      expect {
        delete admin_delivery_period_url(delivery_period)
      }.to change(DeliveryPeriod, :count).by(-1)
    end

    it '配達時間帯削除後のリダイレクト' do
      delivery_period = DeliveryPeriod.create! valid_attributes
      delete admin_delivery_period_url(delivery_period)
      expect(response).to redirect_to(admin_delivery_periods_url)
    end
  end
end
