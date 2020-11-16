class World < ActiveRecord::Migration[6.1]
  def change
    create_table :worlds do |t|
      t.string :name
    end
  end
end
