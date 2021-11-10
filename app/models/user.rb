# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                       :bigint           not null, primary key
#  email                    :string(255)      not null
#  email_verification_token :string(255)
#  email_verified           :boolean          default(FALSE)
#  password_digest          :string(255)
#  remember_token           :string(255)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
# Indexes
#
#  index_users_on_remember_token  (remember_token) UNIQUE
#
class User < ApplicationRecord
  has_secure_password
  has_many :sites
  has_many :goals

  has_many :site_members
  has_many :own_sites, through: :site_members, class_name: "Site"

  validates_format_of :email, with: /\A[^@\s]+@[^@\s]+\z/
  validates :email, uniqueness: true

  before_create { generate_token(:remember_token) }
  before_create { generate_token(:email_verification_token) }

  def generate_token(column)
    begin
      self[column] = SecureRandom.hex(32)
    end while User.exists?(column => self[column])
  end
end
