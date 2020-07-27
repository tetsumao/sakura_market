require 'rails_helper'

RSpec.describe "Coupons", type: :request do
  # ユーザログイン
  before do
    post user_session_url,
      params: {
        user: {
          email: user.email,
          password: 'password',
          remember_me: '0'
        }
      }
  end
  let(:admin) { create(:admin) }
  let(:user) { create(:user) }
  let(:coupon) { create(:coupon, admin_id: admin.id) }
  let(:valid_attributes) {
    {
      coupon_code: coupon.coupon_code
    }
  }
  let(:invalid_attributes) {
    {
      coupon_code: coupon.coupon_code + 'abc'
    }
  }

  describe "GET /index" do
    it '成功した応答をレンダリング' do
      admin.coupons.create!(point: 2000)
      get coupons_url
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context '正常パラメータを入力' do
      it '新しいクーポンを獲得' do
        expect {
          post coupons_url, params: { coupon: valid_attributes }, xhr: true
        }.to change(Coupon, :count).by(1)
        expect(Coupon.last.user_id).to eq(user.id)
      end
    end

    context '不正パラメータを入力' do
      it '新しいクーポンを獲得できない' do
        expect {
          post coupons_url, params: { coupon: invalid_attributes }, xhr: true
        }.to change(Coupon, :count).by(1)
        expect(Coupon.last.user_id).to eq(nil)
      end
    end
  end
end
