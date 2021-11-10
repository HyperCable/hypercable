# frozen_string_literal: true

# == Schema Information
#
# Table name: goals
#
#  id         :bigint           not null, primary key
#  event_name :string(255)
#  path       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  site_id    :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_goals_on_site_id  (site_id)
#  index_goals_on_user_id  (user_id)
#
require "test_helper"

class GoalTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
