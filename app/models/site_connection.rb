# frozen_string_literal: true

class SiteConnection
  attr_reader :site

  def initialize(site)
    @site = site
    @password = password
  end

  def username
    @username ||= "u" + SecureRandom.hex(4)
  end

  def password
    @passowrd ||= SecureRandom.hex(8)
  end

  def create
    ApplicationHyperRecord.connection.execute("CREATE USER #{username} WITH PASSWORD '#{password}';")
    ApplicationHyperRecord.connection.execute("GRANT readonly TO #{username};")
    ApplicationHyperRecord.connection.execute("ALTER ROLE #{username} SET statement_timeout=10000;")
  end
end
