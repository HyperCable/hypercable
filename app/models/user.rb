# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  password_digest :string
#  remember_token  :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_remember_token  (remember_token) UNIQUE
#
class User < ApplicationRecord
  has_many :sites
  has_many :goals

  has_many :site_members
  has_many :own_sites, through: :site_members, class_name: "Site"
end
