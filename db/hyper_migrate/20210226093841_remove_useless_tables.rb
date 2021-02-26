class RemoveUselessTables < ActiveRecord::Migration[6.1]
  def change
    drop_table :hits
    drop_table :sessions
  end
end
