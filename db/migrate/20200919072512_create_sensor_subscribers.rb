class CreateSensorSubscribers < ActiveRecord::Migration[6.0]
  def change
    create_table :sensor_subscribers do |t|
      t.references :sensor, null: false, foreign_key: true
      t.references :subscriber, null: false, foreign_key: true

      t.timestamps
    end
  end
end
