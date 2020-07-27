 require 'rails_helper'

RSpec.describe "/coupons", type: :request do
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

  let(:valid_attributes) { attributes_for(:coupon, admin_id: admin.id) }
  let(:invalid_attributes) { attributes_for(:coupon, admin_id: admin.id, point: 0) }

  describe "GET /index" do
    it '成功した応答をレンダリング' do
      Coupon.create! valid_attributes
      get admin_coupons_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it '成功した応答をレンダリング' do
      coupon = Coupon.create! valid_attributes
      get admin_coupon_url(coupon)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it '成功した応答をレンダリング' do
      get new_admin_coupon_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it '成功した応答' do
      coupon = Coupon.create! valid_attributes
      get edit_admin_coupon_url(coupon)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context '正常パラメータを入力' do
      it '新しいクーポンを作成' do
        expect {
          post admin_coupons_url, params: { coupon: valid_attributes }
        }.to change(Coupon, :count).by(1)
      end

      it '新しいクーポン作成後のリダイレクト' do
        post admin_coupons_url, params: { coupon: valid_attributes }
        expect(response).to redirect_to(admin_coupons_url)
      end
    end

    context '不正パラメータを入力' do
      it "does not create a new Coupon" do
        expect {
          post admin_coupons_url, params: { coupon: invalid_attributes }
        }.to change(Coupon, :count).by(0)
      end

      it '成功した応答をnewテンプレートからレンダリング' do
        post admin_coupons_url, params: { coupon: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context '正常パラメータを入力' do
      let(:new_attributes) {
        {point: 500}
      }

      it "updates the requested coupon" do
        coupon = Coupon.create! valid_attributes
        patch admin_coupon_url(coupon), params: { coupon: new_attributes }
        coupon.reload
        expect(coupon.point).to eq(500)
      end

      it "redirects to the coupon" do
        coupon = Coupon.create! valid_attributes
        patch admin_coupon_url(coupon), params: { coupon: new_attributes }
        coupon.reload
        expect(response).to redirect_to(admin_coupons_url)
      end
    end

    context '不正パラメータを入力' do
      it 'editテンプレートでレンダリングして成功応答' do
        coupon = Coupon.create! valid_attributes
        patch admin_coupon_url(coupon), params: { coupon: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested coupon" do
      coupon = Coupon.create! valid_attributes
      expect {
        delete admin_coupon_url(coupon)
      }.to change(Coupon, :count).by(-1)
    end

    it "redirects to the coupons list" do
      coupon = Coupon.create! valid_attributes
      delete admin_coupon_url(coupon)
      expect(response).to redirect_to(admin_coupons_url)
    end
  end
end
