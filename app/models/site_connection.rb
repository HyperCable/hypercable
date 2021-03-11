# frozen_string_literal: true

# == Schema Information
#
# Table name: site_connections
#
#  id         :bigint           not null, primary key
#  password   :string           not null
#  username   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  site_id    :bigint
#
# Indexes
#
#  index_site_connections_on_site_id  (site_id)
#
class SiteConnection < ApplicationRecord
  belongs_to :site

  before_create do
    username = "u" + SecureRandom.hex(4)
    password = SecureRandom.hex(10)
    ApplicationHyperRecord.connection.execute("CREATE USER #{username} WITH PASSWORD '#{password}';")
    ApplicationHyperRecord.connection.execute("GRANT readonly TO #{username};")
    ApplicationHyperRecord.connection.execute("ALTER ROLE #{username} SET statement_timeout=10000;")
  end
end
