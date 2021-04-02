class CreateMeasurementProtocols < ActiveRecord::Migration[6.1]
  def change
    create_table :measurement_protocols do |t|
      t.bigint :site_id, index: true
      t.string :api_secret, null: false
      t.timestamps
    end
  end
end
