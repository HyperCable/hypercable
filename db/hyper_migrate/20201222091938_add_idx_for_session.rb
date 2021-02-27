class AddIdxForSession < ActiveRecord::Migration[6.1]
  def change
    remove_index :sessions, [:site_id, :session_id, :started_at]

    add_index :sessions, [:site_id, :session_id, :started_at], order: {started_at: :desc}, unique: true
  end
end
