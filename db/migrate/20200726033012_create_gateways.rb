class CreateGateways < ActiveRecord::Migration[6.0]
  def change
    create_table :gateways do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.text :description
      t.text :message
      t.timestamps
    end
  end
end
