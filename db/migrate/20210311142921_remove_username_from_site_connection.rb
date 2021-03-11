class RemoveUsernameFromSiteConnection < ActiveRecord::Migration[6.1]
  def change
    remove_column :site_connections, :username
  end
end
