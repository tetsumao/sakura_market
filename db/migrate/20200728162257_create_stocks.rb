class CreateStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :stocks do |t|
      t.references :trader, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.references :order, foreign_key: true
      t.integer :stock_number, default: 1

      t.timestamps
    end
  end
end
