class CreateActuators < ActiveRecord::Migration[6.0]
  def change
    create_table :actuators do |t|
      t.reference :element
      t.reference :device
      t.float :expected_status
      t.float :current_status

      t.timestamps
    end
  end
end
