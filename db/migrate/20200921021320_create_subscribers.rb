class CreateSubscribers < ActiveRecord::Migration[6.0]
  def change
    create_table :subscribers do |t|
      t.string :fb_id, null: false

      t.timestamps
    end
  end
end
