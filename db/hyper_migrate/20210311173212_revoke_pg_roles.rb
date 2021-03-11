class RevokePgRoles < ActiveRecord::Migration[6.1]
  def change
    execute("REVOKE SELECT ON pg_catalog.pg_roles FROM readonly;")
  end
end
