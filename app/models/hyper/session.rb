# frozen_string_literal: true

# == Schema Information
#
# Table name: sessions
#
#  app_version    :string
#  browser        :string
#  city           :string
#  country        :string
#  device_type    :string
#  duration       :integer          default(0)
#  end_at         :datetime         not null
#  entry_page     :string
#  events         :integer          default(0)
#  exit_page      :string
#  hostname       :string
#  ip             :string
#  is_bounce      :boolean          default(TRUE)
#  landing_page   :string
#  latitude       :float
#  longitude      :float
#  os             :string
#  os_version     :string
#  pageviews      :integer          default(0)
#  pathname       :string
#  platform       :string
#  referer        :string
#  referer_source :string
#  region         :string
#  started_at     :datetime         not null
#  user_agent     :string
#  user_token     :string           not null
#  utm_campaign   :string
#  utm_content    :string
#  utm_medium     :string
#  utm_source     :string
#  utm_term       :string
#  session_id     :string           not null
#  site_id        :integer          not null
#  user_id        :string
#
# Indexes
#
#  index_sessions_on_site_id_and_session_id_and_started_at  (site_id,session_id,started_at DESC)
#  sessions_started_at_idx                                  (started_at)
#
module Hyper
  class Session < ApplicationHyperRecord
  end
end
