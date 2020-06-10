class CreateSensors < ActiveRecord::Migration[6.0]
  def change
    create_table :sensors do |t|
      t.references :device
      t.references :variable
      t.float :value

      t.timestamps
    end
  end
end
