class CreateSiteMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :site_members do |t|
      t.bigint :site_id
      t.bigint :user_id
      t.timestamps
      t.index [:site_id, :user_id], unique: true
    end
  end
end
