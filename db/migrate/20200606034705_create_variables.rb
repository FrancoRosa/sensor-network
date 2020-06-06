class CreateVariables < ActiveRecord::Migration[6.0]
  def change
    create_table :variables do |t|
      t.string :name
      t.string :unit

      t.timestamps
    end
  end
end
