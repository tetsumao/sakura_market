class Trader::ShippingsController < Trader::Base
  before_action :set_shipping, only: [:show, :edit, :update, :destroy]

  def index
    @shippings = current_trader.shippings.page(params[:page]).per(20)
  end

  def show
  end

  def new
    @shipping = current_trader.shippings.build
  end

  def edit
  end

  def create
    @shipping = current_trader.shippings.build(shipping_params)

    if @shipping.save
      redirect_to trader_shippings_url, notice: '送料を作成しました。'
    else
      render :new
    end
  end

  def update
    if @shipping.update(shipping_params)
      redirect_to trader_shippings_url, notice: '送料を更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @shipping.destroy
    redirect_to trader_shippings_url, notice: '送料を削除しました。'
  end

  private
    def set_shipping
      @shipping = current_trader.shippings.find(params[:id])
    end

    def shipping_params
      params.require(:shipping).permit(:shipping_name, :quantity, :price)
    end
end
