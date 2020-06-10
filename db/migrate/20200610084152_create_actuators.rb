class CreateActuators < ActiveRecord::Migration[6.0]
  def change
    create_table :actuators do |t|
      t.references :device, null: false, foreign_key: true
      t.references :element, null: false, foreign_key: true
      t.float :expected_status
      t.float :current_status

      t.timestamps
    end
  end
end
