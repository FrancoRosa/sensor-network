class CreateDevices < ActiveRecord::Migration[6.0]
  def change
    create_table :devices do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.text :description
      t.integer :tx_period
      t.integer :tx_slot
      t.integer :rx_time

      t.timestamps
    end
  end
end
