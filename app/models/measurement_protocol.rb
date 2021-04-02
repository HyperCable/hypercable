# frozen_string_literal: true

# == Schema Information
#
# Table name: measurement_protocols
#
#  id         :bigint           not null, primary key
#  api_secret :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  site_id    :bigint
#
# Indexes
#
#  index_measurement_protocols_on_site_id  (site_id)
#
class MeasurementProtocol < ApplicationRecord
  belongs_to :site

  before_create do
    self.api_secret = SecureRandom.hex(20)
  end

  after_create do
    RedisClient.set(api_secret, site.uuid)
  end

  before_destroy do
    RedisClient.del(api_secret)
  end
end
