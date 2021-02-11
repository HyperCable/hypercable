class UseUuidForSiteId < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pgcrypto'
    add_column :sites, :uuid, :uuid, default: "gen_random_uuid()", null: false
    add_index :sites, :uuid, unique: true
  end
end