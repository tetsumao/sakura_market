class AddOrderStatusAndStripeInvidToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :order_status, :integer, default: 0
    add_column :orders, :stripe_invid, :string
  end
end
