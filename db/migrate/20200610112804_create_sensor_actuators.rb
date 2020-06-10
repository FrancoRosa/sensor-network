class CreateSensorActuators < ActiveRecord::Migration[6.0]
  def change
    create_table :sensor_actuators do |t|
      t.references :sensor, null: false, foreign_key: true
      t.references :actuator, null: false, foreign_key: true
      t.references :command, null: false, foreign_key: true
      t.boolean :enable, default: false
      t.float :threshold

      t.timestamps
    end
  end
end
