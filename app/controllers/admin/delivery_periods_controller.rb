class Admin::DeliveryPeriodsController < Admin::Base
  before_action :set_delivery_period, only: [:show, :edit, :update, :destroy]

  def index
    @delivery_periods = DeliveryPeriod.default_order.page(params[:page]).per(20)
  end

  def show
  end

  def new
    @delivery_period = DeliveryPeriod.new
  end

  def edit
  end

  def create
    @delivery_period = DeliveryPeriod.new(delivery_period_params)

    if @delivery_period.save
      redirect_to admin_delivery_periods_url, notice: '配達時間帯を作成しました。'
    else
      render :new
    end
  end

  def update
    if @delivery_period.update(delivery_period_params)
      redirect_to admin_delivery_periods_url, notice: '配達時間帯を更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @delivery_period.destroy
    redirect_to admin_delivery_periods_url, notice: '配達時間帯を削除しました。'
  end

  private
    def set_delivery_period
      @delivery_period = DeliveryPeriod.find(params[:id])
    end

    def delivery_period_params
      params.require(:delivery_period).permit(:hour_from, :hour_to)
    end
end
