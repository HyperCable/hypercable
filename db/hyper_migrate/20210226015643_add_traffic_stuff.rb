class AddTrafficStuff < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :traffic_campaign, :string
    add_column :events, :traffic_medium, :string
    add_column :events, :traffic_source, :string
  end
end
