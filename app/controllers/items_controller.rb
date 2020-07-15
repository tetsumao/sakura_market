class ItemsController < ApplicationController
  before_action :set_item, only: [:show]
  before_action :set_item_ids_in_cart, only: [:index, :show]

  def index
    @items = Item.enabled.default_order.page(params[:page]).per(9)
  end

  def show
    @item = Item.enabled.find(params[:id])
  end

  private
    def set_item
      @item = Item.enabled.find(params[:id])
    end
    def set_item_ids_in_cart
      @item_ids_in_cart = current_user.present? ? current_user.cart_items.pluck(:item_id) : []
    end
end
