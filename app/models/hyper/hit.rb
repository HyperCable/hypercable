# frozen_string_literal: true

# == Schema Information
#
# Table name: hits
#
#  app_version     :string
#  browser         :string
#  city            :string
#  country         :string
#  device_type     :string
#  hostname        :string
#  ip              :string
#  landing_page    :string
#  latitude        :float
#  longitude       :float
#  name            :string
#  os              :string
#  os_version      :string
#  pathname        :string
#  platform        :string
#  props           :jsonb
#  referrer        :string
#  referrer_source :string
#  region          :string
#  started_at      :datetime         not null
#  user_agent      :string
#  user_token      :string           not null
#  utm_campaign    :string
#  utm_content     :string
#  utm_medium      :string
#  utm_source      :string
#  utm_term        :string
#  session_id      :string           not null
#  site_id         :integer          not null
#  user_id         :string
#
# Indexes
#
#  hits_started_at_idx                                  (started_at)
#  index_hits_on_site_id_and_session_id_and_started_at  (site_id,session_id,started_at DESC)
#
module Hyper
  class Hit < ApplicationHyperRecord
  end
end
