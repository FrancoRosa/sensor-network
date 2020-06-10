class CreateActuatorHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :actuator_histories do |t|
      t.references :actuator, null: false, foreign_key: true
      t.float :expected_status
      t.float :current_status

      t.timestamps
    end
  end
end
