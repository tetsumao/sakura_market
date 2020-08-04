class Admin::TradersController < Admin::Base
  before_action :set_trader, only: [:show, :edit, :update, :destroy]

  def index
    @traders = Trader.default_order.page(params[:page]).per(20)
  end

  def show
  end

  def new
    @trader = Trader.new
  end

  def edit
  end

  def create
    @trader = Trader.new(trader_params)

    if @trader.save
      redirect_to admin_traders_url, notice: '事業者を作成しました。'
    else
      render :new
    end
  end

  def update
    tps = trader_params
    tps.delete(:password) if tps.has_key?(:password) && tps[:password].empty?
    if @trader.update(tps)
      redirect_to admin_traders_url, notice: '事業者を更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @trader.destroy
    redirect_to admin_traders_url, notice: '事業者を削除しました。'
  end

  private
    def set_trader
      @trader = Trader.find(params[:id])
    end

    def trader_params
      params.require(:trader).permit(:email, :password, :trader_name)
    end
end
