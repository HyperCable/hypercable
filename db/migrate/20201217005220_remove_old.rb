class RemoveOld < ActiveRecord::Migration[6.1]
  def change
    drop_table :hellos
  end
end
