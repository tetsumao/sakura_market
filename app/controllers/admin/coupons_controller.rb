class Admin::CouponsController < Admin::Base
  before_action :set_coupon, only: [:show, :edit, :update, :destroy]

  def index
    @coupons = Coupon.default_order.page(params[:page]).per(20)
  end

  def show
  end

  def new
    @coupon = current_admin.coupons.build
  end

  def edit
  end

  def create
    @coupon = current_admin.coupons.build(coupon_params)

    if @coupon.save
      redirect_to admin_coupons_url, notice: 'クーポンを作成しました。'
    else
      render :new
    end
  end

  def update
    if @coupon.update(coupon_params)
      redirect_to admin_coupons_url, notice: 'クーポンを更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @coupon.destroy
    redirect_to admin_coupons_url, notice: 'クーポンを削除しました。'
  end

  private
    def set_coupon
      @coupon = Coupon.find(params[:id])
    end

    def coupon_params
      params.require(:coupon).permit(:user_id, :point)
    end
end
