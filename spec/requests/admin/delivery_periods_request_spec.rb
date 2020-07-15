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
    it "renders a successful response" do
      DeliveryPeriod.create! valid_attributes
      get admin_delivery_periods_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      delivery_period = DeliveryPeriod.create! valid_attributes
      get admin_delivery_period_url(delivery_period)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_admin_delivery_period_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      delivery_period = DeliveryPeriod.create! valid_attributes
      get edit_admin_delivery_period_url(delivery_period)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new DeliveryPeriod" do
        expect {
          post admin_delivery_periods_url, params: { delivery_period: valid_attributes }
        }.to change(DeliveryPeriod, :count).by(1)
      end

      it "redirects to the created delivery_period" do
        post admin_delivery_periods_url, params: { delivery_period: valid_attributes }
        expect(response).to redirect_to(admin_delivery_periods_url)
      end
    end

    context "with invalid parameters" do
      it "does not create a new DeliveryPeriod" do
        expect {
          post admin_delivery_periods_url, params: { delivery_period: invalid_attributes }
        }.to change(DeliveryPeriod, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post admin_delivery_periods_url, params: { delivery_period: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {hour_to: 21}
      }

      it "updates the requested delivery_period" do
        delivery_period = DeliveryPeriod.create! valid_attributes
        patch admin_delivery_period_url(delivery_period), params: { delivery_period: new_attributes }
        delivery_period.reload
        expect(delivery_period.hour_to).to eq(21)
      end

      it "redirects to the delivery_period" do
        delivery_period = DeliveryPeriod.create! valid_attributes
        patch admin_delivery_period_url(delivery_period), params: { delivery_period: new_attributes }
        delivery_period.reload
        expect(response).to redirect_to(admin_delivery_periods_url)
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        delivery_period = DeliveryPeriod.create! valid_attributes
        patch admin_delivery_period_url(delivery_period), params: { delivery_period: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested delivery_period" do
      delivery_period = DeliveryPeriod.create! valid_attributes
      expect {
        delete admin_delivery_period_url(delivery_period)
      }.to change(DeliveryPeriod, :count).by(-1)
    end

    it "redirects to the delivery_periods list" do
      delivery_period = DeliveryPeriod.create! valid_attributes
      delete admin_delivery_period_url(delivery_period)
      expect(response).to redirect_to(admin_delivery_periods_url)
    end
  end
end
