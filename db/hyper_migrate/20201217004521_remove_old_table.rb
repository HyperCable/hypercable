class RemoveOldTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :worlds
    drop_table :events
    drop_table :visits
  end
end
