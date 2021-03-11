class RevokePublic < ActiveRecord::Migration[6.1]
  def change
    current_db_name = connection.current_database
    execute("REVOKE SELECT ON pg_catalog.pg_roles FROM public;")
    execute("REVOKE SELECT ON pg_catalog.pg_roles FROM readonly;")

    execute("REVOKE SELECT ON pg_catalog.pg_authid FROM public;")
    execute("REVOKE SELECT ON pg_catalog.pg_authid FROM readonly;")

    execute("revoke create on schema public from PUBLIC;")
    execute("REVOKE ALL ON DATABASE #{current_db_name} FROM PUBLIC;")
  end
end