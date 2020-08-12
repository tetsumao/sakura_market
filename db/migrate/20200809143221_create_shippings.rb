class CreateShippings < ActiveRecord::Migration[6.0]
  def change
    create_table :shippings do |t|
      t.references :trader, null: false, foreign_key: true
      t.string :shipping_name
      t.integer :quantity, null: false
      t.integer :price, null: false

      t.timestamps
    end
  end
end
