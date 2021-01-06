# frozen_string_literal: true

# == Schema Information
#
# Table name: hits
#
#  app_version         :string
#  browser             :string
#  city                :string
#  country             :string
#  data_source         :string           default("web")
#  device_type         :string
#  event_name          :string           default("page_view")
#  event_props         :jsonb
#  hostname            :string
#  ip                  :string
#  latitude            :float
#  location_url        :string
#  longitude           :float
#  non_interaction_hit :boolean          default(FALSE)
#  os                  :string
#  os_version          :string
#  path                :string
#  platform            :string
#  protocol_version    :string           default("2")
#  referrer            :string
#  referrer_source     :string
#  region              :string
#  screen_resolution   :string
#  started_at          :datetime         not null
#  title               :string
#  user_agent          :string
#  user_language       :string
#  user_props          :jsonb
#  utm_campaign        :string
#  utm_content         :string
#  utm_medium          :string
#  utm_source          :string
#  utm_term            :string
#  client_id           :string           not null
#  session_id          :string           not null
#  site_id             :integer          not null
#  tracking_id         :string           not null
#  user_id             :string
#
# Indexes
#
#  hits_started_at_idx                                  (started_at)
#  index_hits_on_site_id_and_session_id_and_started_at  (site_id,session_id,started_at DESC)
#
module Hyper
  class Hit < ApplicationHyperRecord
    ATTRS = %W[
      site_id
      session_id
      client_id
      user_id
      tracking_id

      protocol_version
      data_source

      location_url
      hostname
      path
      title
      user_agent
      ip
      referrer
      referrer_source
      screen_resolution
      user_language

      country
      region
      city
      latitude
      longitude

      utm_source
      utm_medium
      utm_term
      utm_content
      utm_campaign

      browser
      os
      device_type
    ]
  end
end
