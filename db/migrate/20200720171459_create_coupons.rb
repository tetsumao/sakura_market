class CreateCoupons < ActiveRecord::Migration[6.0]
  def change
    create_table :coupons do |t|
      t.string :coupon_code
      t.references :admin, null: false, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :point, null: false, default: 0
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
