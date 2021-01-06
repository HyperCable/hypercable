# frozen_string_literal: true

# == Schema Information
#
# Table name: sessions
#
#  browser           :string
#  city              :string
#  country           :string
#  data_source       :string           default("web")
#  device_type       :string
#  duration          :integer          default(0)
#  end_at            :datetime         not null
#  entry_page        :string
#  events            :integer          default(0)
#  exit_page         :string
#  hostname          :string
#  ip                :string
#  is_bounce         :boolean          default(TRUE)
#  landing_page      :string
#  latitude          :float
#  location_url      :string
#  longitude         :float
#  os                :string
#  pageviews         :integer          default(0)
#  path              :string
#  protocol_version  :string           default("2")
#  referrer          :string
#  referrer_source   :string
#  region            :string
#  screen_resolution :string
#  started_at        :datetime         not null
#  title             :string
#  user_agent        :string
#  user_language     :string
#  utm_campaign      :string
#  utm_content       :string
#  utm_medium        :string
#  utm_source        :string
#  utm_term          :string
#  client_id         :string           not null
#  session_id        :string           not null
#  site_id           :integer          not null
#  tracking_id       :string           not null
#  user_id           :string
#
# Indexes
#
#  index_sessions_on_site_id_and_session_id_and_started_at  (site_id,session_id,started_at DESC) UNIQUE
#  sessions_started_at_idx                                  (started_at)
#
module Hyper
  class Session < ApplicationHyperRecord
  end
end
