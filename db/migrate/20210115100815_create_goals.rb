class CreateGoals < ActiveRecord::Migration[6.1]
  def change
    create_table :goals do |t|
      t.bigint :user_id, index: true
      t.bigint :site_id, index: true
      t.string :event_name
      t.string :path
      t.timestamps
    end
  end
end
