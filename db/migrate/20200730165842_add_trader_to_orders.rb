class AddTraderToOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :trader, foreign_key: true
  end
end
