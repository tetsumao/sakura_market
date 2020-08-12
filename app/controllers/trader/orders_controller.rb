class Trader::OrdersController < Trader::Base
  before_action :set_order, only: [:show, :update]

  def index
    @orders = current_trader.orders.page(params[:page]).per(20)
  end

  def show
  end

  def update
    if @order.update(order_params)
      redirect_to [:trader, @order], notice: 'ステータス変更しました'
    else
      redirect_to [:trader, @order], alert: @order.toastr_error_message('ステータス変更できません:')
    end
  end

  private
    def set_order
      @order = current_trader.orders.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:order_status)
    end
end
