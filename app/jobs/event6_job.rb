# frozen_string_literal: true

class Event6Job < EventJob
  include Sidekiq::Worker

  sidekiq_options queue: "event6"
end
