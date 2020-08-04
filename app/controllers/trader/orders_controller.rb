class Trader::OrdersController < Trader::Base
  before_action :set_order, only: [:show]

  def index
    @orders = current_trader.orders.page(params[:page]).per(20)
  end

  def show
  end

  private
    def set_order
      @order = current_trader.orders.find(params[:id])
    end
end
