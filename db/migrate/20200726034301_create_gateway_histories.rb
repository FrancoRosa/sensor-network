class CreateGatewayHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :gateway_histories do |t|
      t.references :gateway, null: false, foreign_hey: true
      t.string :message
      
      t.timestamps
    end
  end
end
