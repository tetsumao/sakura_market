class CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart_item, only: [:update, :destroy]

  def index
    @cart_items = current_user.cart_items.eager_load(:item)
    if @cart_items.empty?
      redirect_to items_url, notice: 'カートに商品がありません。'
    end
  end

  def create
    @cart_item = current_user.cart_items.build(cart_item_params)
    respond_to do |format|
      if @cart_item.save
        format.html { redirect_to items_path, notice: "#{@cart_item.item.item_name} x #{@cart_item.quantity} をカートに追加しました。" }
        format.js
      else
        format.html { redirect_to @cart_item.item, alert: @cart_item.toastr_error_message('カートに追加できませんでした：') }
        format.js
      end
    end
  end

  def update
    if @cart_item.update(cart_item_update_params)
      redirect_to cart_items_url, notice: 'カートの商品の数量を変更しました。'
    else
      redirect_to cart_items_url, alert: 'カートの商品の数量が変更できませんでした。'
    end
  end

  def destroy
    @cart_item.destroy
    redirect_to cart_items_url, notice: 'カートの商品を削除しました。'
  end

  private
    def set_cart_item
      @cart_item = current_user.cart_items.find(params[:id])
    end

    def cart_item_params
      params.require(:cart_item).permit(:item_id, :quantity)
    end
    def cart_item_update_params
      params.require(:cart_item).permit(:quantity)
    end
end
