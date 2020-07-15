class Admin::ItemsController < Admin::Base
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.default_order.page(params[:page]).per(20)
  end

  def show
  end

  def new
    @item = Item.new
    @item.dspo = Item.next_dspo
  end

  def edit
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to admin_items_url, notice: '商品を作成しました。'
    else
      render :new
    end
  end

  def update
    if @item.update(item_params)
      redirect_to admin_items_url, notice: '商品を更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to admin_items_url, notice: '商品を削除しました。'
  end

  private
    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:item_name, :picture, :price, :description, :disabled, :dspo)
    end
end
