class ResetData < ActiveRecord::Migration[6.1]
  def change
    execute("TRUNCATE events")
  end
end
