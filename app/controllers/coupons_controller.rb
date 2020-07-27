class CouponsController < ApplicationController
  before_action :authenticate_user!

  def index
    @coupons = current_user.coupons.default_order.page(params[:page]).per(20)
  end

  def create
    coupon_code = params.require(:coupon).require(:coupon_code).gsub('-', '')
    @coupon = Coupon.where(user_id: nil).find_by(coupon_code: coupon_code)
    if @coupon.present? && @coupon.update(user: current_user)
      redirect_to coupons_url, notice: "#{@coupon.point} ポイント獲得しました。"
    end
  end
end
