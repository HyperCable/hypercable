# frozen_string_literal: true

class Event4Job < EventJob
  include Sidekiq::Worker

  sidekiq_options queue: "event4"
end
