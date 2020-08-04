class ItemsController < ApplicationController
  before_action :set_item, only: [:show]
  before_action :set_item_ids_in_cart

  def index
    cart_item = user_signed_in? ? current_user.cart_items.first : nil
    @trader = cart_item.nil? ? Trader.find_by(id: params[:trader_id]) : cart_item.trader
    @items = Item.enabled.where(id: @trader.present? ? @trader.items : []).default_order.page(params[:page]).per(9)
    @traders = Trader.all
  end

  def show
    @trader = Trader.find(params[:trader_id])
  end

  private
    def set_item
      @item = Item.enabled.find(params[:id])
    end
    def set_item_ids_in_cart
      @item_ids_in_cart = current_user.present? ? current_user.cart_items.pluck(:item_id) : []
    end
end
