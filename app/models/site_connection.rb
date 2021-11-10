# frozen_string_literal: true

# == Schema Information
#
# Table name: site_connections
#
#  id         :bigint           not null, primary key
#  password   :string(255)      not null
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
    username = site.uuid
    self.password = SecureRandom.hex(10)
    ApplicationHyperRecord.connection.execute(%Q[CREATE USER "#{username}" WITH PASSWORD '#{password}'])
    ApplicationHyperRecord.connection.execute(%Q[GRANT readonly TO "#{username}"])
    ApplicationHyperRecord.connection.execute(%Q[ALTER ROLE "#{username}" SET statement_timeout=10000])
  end

  before_destroy do
    ApplicationHyperRecord.connection.execute(%Q[DROP USER IF EXISTS "#{site.uuid}"])
  end

  # TODO replace host & port
  def link
    "postgresql://#{site.uuid}:#{password}@#{ENV["HOST"].to_s.split(":").first}:5532/#{ApplicationHyperRecord.connection.current_database}"
  end
end
