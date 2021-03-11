class AddPolicy < ActiveRecord::Migration[6.1]
  def change
    execute(<<~SQL)
      create policy event_access on events for select using (site_id = current_user::text)
    SQL
  end
end
