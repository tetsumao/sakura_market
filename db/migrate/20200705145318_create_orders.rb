class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.date :delivery_date
      t.references :delivery_period, foreign_key: true
      t.integer :item_price, null: false
      t.integer :charge_price, null: false
      t.integer :shipping_price, null: false
      t.integer :tax_price, null: false
      t.string :ship_zip, null: false
      t.string :ship_address, null: false

      t.timestamps
    end
  end
end
