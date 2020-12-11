class AddSiteIdForVisitAndEvent < ActiveRecord::Migration[6.1]
  def change
    add_column :visits, :site_id, :integer
    add_column :events, :site_id, :integer
  end
end
