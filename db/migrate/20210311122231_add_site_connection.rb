class AddSiteConnection < ActiveRecord::Migration[6.1]
  def change
    create_table :site_connections do |t|
      t.bigint :site_id, index: true
      t.string :username, null: false
      t.string :password, null: false
      t.timestamps
    end
  end
end