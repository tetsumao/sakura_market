class CreateOrderShippings < ActiveRecord::Migration[6.0]
  def change
    create_table :order_shippings do |t|
      t.references :order, null: false, foreign_key: true
      t.references :shipping, foreign_key: true
      t.integer :box, null: false
      t.string :shipping_name
      t.integer :price, null: false

      t.timestamps
    end
  end
end
