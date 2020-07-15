class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show]

  def index
    @orders = current_user.orders.page(params[:page]).per(20)
  end

  def show
  end

  def new
    @order = current_user.orders.build
    @order.apply_cart_items(current_user.cart_items.eager_load(:item))
    if @order.order_items.present?
      @order.ship_zip = current_user.zip
      @order.ship_address = current_user.address
      @update_ship = 1
    else
      redirect_to root_path, notice: 'カートに商品がありません。'
    end
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.apply_cart_items(current_user.cart_items.eager_load(:item))
    if @order.order_items.present?
      @update_ship = params[:update_ship].to_i
      if @order.save
        current_user.cart_items.destroy_all
        current_user.update!(zip: @order.ship_zip, address: @order.ship_address) if @update_ship == 1
        redirect_to @order, notice: '注文しました。'
      else
        render :new
      end
    else
      redirect_to root_path, notice: 'カートに商品がありません。'
    end
  end

  private
    def set_order
      @order = current_user.orders.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:ship_zip, :ship_address, :delivery_date, :delivery_period_id)
    end
end
