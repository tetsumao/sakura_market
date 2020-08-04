class AddTraderToCartItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :cart_items, :trader, foreign_key: true
  end
end
