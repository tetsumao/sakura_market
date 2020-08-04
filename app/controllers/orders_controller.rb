class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show]
  before_action :build_order, only: [:confirm, :create]

  def index
    @orders = current_user.orders.page(params[:page]).per(20)
  end

  def show
  end

  def new
    @coupon_use = session.fetch(:coupon_use, 0).to_i
    @coupon_use_point = session.fetch(:coupon_use_point, current_user.coupon_point).to_i
    @update_ship = session.fetch(:update_ship, 1).to_i
    @order = current_user.orders.build(session.fetch(:order, {}))
    @order.apply_cart_items(current_user.cart_items.eager_load(:item))
    if @order.order_items.present?
      @order.ship_zip = current_user.zip if @order.ship_zip.blank?
      @order.ship_address = current_user.address if @order.ship_address.blank?
    else
      redirect_to items_url, notice: 'カートに商品がありません。'
    end
  end

  def confirm
    if @order.order_items.present?
      if @order.valid?
        # 再入力用としてセッションに入力情報を保持
        session[:coupon_use] = @coupon_use
        session[:coupon_use_point] = @coupon_use_point
        session[:update_ship] = @update_ship
        session[:order] = order_params
      else
        render :new
      end
    else
      redirect_to items_url, notice: 'カートに商品がありません。'
    end
  end

  def create
    if @order.order_items.present?
      if @order.save
        current_user.cart_items.destroy_all
        current_user.update!(zip: @order.ship_zip, address: @order.ship_address) if @update_ship == 1
        # セッション情報クリア
        session[:coupon_use] = nil
        session[:coupon_use_point] = nil
        session[:update_ship] = nil
        session[:order] = nil
        redirect_to @order, notice: '注文しました。'
      else
        render :new
      end
    else
      redirect_to items_url, notice: 'カートに商品がありません。'
    end
  end

  private
    def set_order
      @order = current_user.orders.find(params[:id])
    end

    def build_order
      @coupon_use = params[:coupon_use].to_i
      @coupon_use_point = params[:coupon_use_point].to_i
      @update_ship = params[:update_ship].to_i
      use_point = 0
      case @coupon_use
      when 1 # 全てのポイントを使用
        use_point = current_user.coupon_point
      when 2 # 指定ポイントを使用
        use_point = @coupon_use_point
      end

      @order = current_user.orders.build(order_params)
      @order.apply_cart_items(current_user.cart_items.eager_load(:item), use_point)
    end

    def order_params
      params.require(:order).permit(:ship_zip, :ship_address, :delivery_date, :delivery_period_id)
    end
end
