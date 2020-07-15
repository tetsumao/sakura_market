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
    it "renders a successful response" do
      Charge.create! valid_attributes
      get admin_charges_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      charge = Charge.create! valid_attributes
      get admin_charge_url(charge)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_admin_charge_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      charge = Charge.create! valid_attributes
      get edit_admin_charge_url(charge)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Charge" do
        expect {
          post admin_charges_url, params: { charge: valid_attributes }
        }.to change(Charge, :count).by(1)
      end

      it "redirects to the created charge" do
        post admin_charges_url, params: { charge: valid_attributes }
        expect(response).to redirect_to(admin_charges_url)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Charge" do
        expect {
          post admin_charges_url, params: { charge: invalid_attributes }
        }.to change(Charge, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post admin_charges_url, params: { charge: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {charge: 999}
      }

      it "updates the requested charge" do
        charge = Charge.create! valid_attributes
        patch admin_charge_url(charge), params: { charge: new_attributes }
        charge.reload
        expect(charge.charge).to eq(999)
      end

      it "redirects to the charge" do
        charge = Charge.create! valid_attributes
        patch admin_charge_url(charge), params: { charge: new_attributes }
        charge.reload
        expect(response).to redirect_to(admin_charges_url)
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        charge = Charge.create! valid_attributes
        patch admin_charge_url(charge), params: { charge: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested charge" do
      charge = Charge.create! valid_attributes
      expect {
        delete admin_charge_url(charge)
      }.to change(Charge, :count).by(-1)
    end

    it "redirects to the charges list" do
      charge = Charge.create! valid_attributes
      delete admin_charge_url(charge)
      expect(response).to redirect_to(admin_charges_url)
    end
  end
end
