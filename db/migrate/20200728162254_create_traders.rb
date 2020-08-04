class CreateTraders < ActiveRecord::Migration[6.0]
  def change
    create_table :traders do |t|
      t.string :email
      t.string :password_digest
      t.string :trader_name, null: false

      t.timestamps
    end
    add_index :traders, 'LOWER(email)', unique: true
  end
end
