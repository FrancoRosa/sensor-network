class CreateCommands < ActiveRecord::Migration[6.0]
  def change
    create_table :commands do |t|
      t.string :name
      t.string :condition
      t.float :status

      t.timestamps
    end
  end
end
