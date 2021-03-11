class DefaultRoleForUser < ActiveRecord::Migration[6.1]
  def change
    current_db_name = connection.current_database
    execute("CREATE ROLE readonly;")
    execute("GRANT USAGE ON SCHEMA public TO readonly;")
    execute("GRANT CONNECT ON DATABASE #{current_db_name} TO readonly;")
    execute("GRANT SELECT ON events TO readonly;")
  end
end
