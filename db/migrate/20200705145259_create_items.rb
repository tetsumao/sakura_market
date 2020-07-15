class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :item_name, null: false
      t.string :picture
      t.integer :price, null: false
      t.text :description
      t.boolean :disabled, default: false, null: false
      t.integer :dspo, default: 0, null: false

      t.timestamps
    end
  end
end
