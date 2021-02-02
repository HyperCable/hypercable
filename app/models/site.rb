# frozen_string_literal: true

# == Schema Information
#
# Table name: sites
#
#  id          :bigint           not null, primary key
#  domain      :string
#  public      :boolean          default(FALSE)
#  timezone    :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  tracking_id :string
#  user_id     :bigint
#
# Indexes
#
#  index_sites_on_tracking_id  (tracking_id) UNIQUE
#  index_sites_on_user_id      (user_id)
#
class Site < ApplicationRecord
  belongs_to :user
  has_many :goals

  has_many :site_members
  has_many :members, through: :site_members, class_name: "User"

  has_many :shared_links
end
