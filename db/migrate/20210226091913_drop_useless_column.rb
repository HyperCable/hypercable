class DropUselessColumn < ActiveRecord::Migration[6.1]
  def change
    remove_column :events, :non_interaction_hit
    remove_column :events, :utm_source
    remove_column :events, :utm_medium
    remove_column :events, :utm_campaign
    remove_column :events, :utm_term
    remove_column :events, :utm_content
  end
end
