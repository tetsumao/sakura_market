class Admin::ChargesController < Admin::Base
  before_action :set_charge, only: [:show, :edit, :update, :destroy]

  def index
    @charges = Charge.default_order.page(params[:page]).per(20)
  end

  def show
  end

  def new
    @charge = Charge.new
  end

  def edit
  end

  def create
    @charge = Charge.new(charge_params)

    if @charge.save
      redirect_to admin_charges_url, notice: '代引き手数料を作成しました。'
    else
      render :new
    end
  end

  def update
    if @charge.update(charge_params)
      redirect_to admin_charges_url, notice: '代引き手数料を更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @charge.destroy
    redirect_to admin_charges_url, notice: '代引き手数料を削除しました。'
  end

  private
    def set_charge
      @charge = Charge.find(params[:id])
    end

    def charge_params
      params.require(:charge).permit(:price_from, :price_to, :charge)
    end
end
