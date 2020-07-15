class CreateAdmins < ActiveRecord::Migration[6.0]
  def change
    create_table :admins do |t|
      t.string :login_name, null: false
      t.string :password_digest
      t.string :admin_name, null: false
      t.integer :dspo, default: 0

      t.timestamps
    end

    add_index :admins, 'LOWER(login_name)', unique: true
  end
end
