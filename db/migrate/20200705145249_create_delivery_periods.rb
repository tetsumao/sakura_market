class CreateDeliveryPeriods < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_periods do |t|
      t.integer :hour_from, null: false
      t.integer :hour_to, null: false

      t.timestamps
    end
  end
end
