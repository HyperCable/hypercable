# frozen_string_literal: true

class ApplicationHyperRecord < ActiveRecord::Base
  self.abstract_class = true
  connects_to database: { writing: :hyper, reading: :hyper }
end
