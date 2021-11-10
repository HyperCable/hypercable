class UseUuidForSiteId < ActiveRecord::Migration[6.1]
  def change
    add_column :sites, :uuid, :string, null: false
    add_index :sites, :uuid, unique: true
  end
end