class CreateCharges < ActiveRecord::Migration[6.0]
  def change
    create_table :charges do |t|
      t.integer :price_from
      t.integer :price_to
      t.integer :charge, null: false

      t.timestamps
    end
  end
end
