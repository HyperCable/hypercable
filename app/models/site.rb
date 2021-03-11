# frozen_string_literal: true

# == Schema Information
#
# Table name: sites
#
#  id          :bigint           not null, primary key
#  domain      :string
#  public      :boolean          default(FALSE)
#  timezone    :string
#  uuid        :uuid             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  tracking_id :string
#  user_id     :bigint
#
# Indexes
#
#  index_sites_on_tracking_id  (tracking_id) UNIQUE
#  index_sites_on_user_id      (user_id)
#  index_sites_on_uuid         (uuid) UNIQUE
#
class Site < ApplicationRecord
  belongs_to :user
  has_many :goals

  has_many :site_members
  has_many :members, through: :site_members, class_name: "User"

  has_many :shared_links
  has_many :site_connections

  validates :domain, presence: true
  validates :tracking_id, presence: true

  def to_param
    uuid
  end

  def utc_offset
    # Beijing -> 28800
    ActiveSupport::TimeZone[timezone].utc_offset
  end

  def utc_offset_hours
    # Beijing -> 8
    utc_offset / 60 / 60.0
  end

  def utc_offset_string
    # Beijing -> +08:00
    ActiveSupport::TimeZone[timezone].formatted_offset
  end

  def visitors_count_of_24h
    current_range = (1.days.ago.in_time_zone(timezone).to_s(:db)..)
    Hyper::Event.where(site_id: uuid).where(started_at: current_range).distinct.count(:client_id)
  end
end
