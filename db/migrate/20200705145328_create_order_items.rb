class CreateOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :item, foreign_key: true
      t.integer :quantity, null: false
      t.string :item_name
      t.string :picture
      t.integer :price, null: false

      t.timestamps
    end
  end
end