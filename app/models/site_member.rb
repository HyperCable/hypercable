# frozen_string_literal: true

# == Schema Information
#
# Table name: site_members
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  site_id    :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_site_members_on_site_id_and_user_id  (site_id,user_id) UNIQUE
#
class SiteMember < ApplicationRecord
  belongs_to :user
  belongs_to :site
end
