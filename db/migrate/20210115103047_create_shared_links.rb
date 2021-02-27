class CreateSharedLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :shared_links do |t|
      t.bigint :site_id, index: true
      t.string :slug, index: {unique: true}
      t.timestamps
    end
  end
end
