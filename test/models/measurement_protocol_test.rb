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
require "test_helper"

class MeasurementProtocolTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
