class Trader::StocksController < Trader::Base
  before_action :set_stock, only: [:edit, :update, :destroy]

  def index
    @items = current_trader.items.default_order
    @stocks = current_trader.stocks.default_order.page(params[:page]).per(20)
  end

  def show
    @stock = current_trader.stocks.find(params[:id])
  end

  def new
    @stock = current_trader.stocks.build
  end

  def edit
  end

  def create
    @stock = current_trader.stocks.build(stock_params)

    if @stock.save
      redirect_to trader_stocks_url, notice: '在庫を登録しました。'
    else
      render :new
    end
  end

  def update
    if @stock.update(stock_params)
      redirect_to trader_stocks_url, notice: '在庫を更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @stock.destroy
    redirect_to trader_stocks_url, notice: '在庫を削除しました。'
  end

  private
    def set_stock
      @stock = current_trader.stocks.updatable.find(params[:id])
    end

    def stock_params
      params.require(:stock).permit(:item_id, :order_item_id, :stock_number)
    end
end
