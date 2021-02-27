class CreateSites < ActiveRecord::Migration[6.1]
  def change
    create_table :sites do |t|
      t.bigint :user_id, index: true
      t.string :tracking_id, index: {unique: true}
      t.string :timezone
      t.boolean :public, default: false
      t.timestamps
    end
  end
end
