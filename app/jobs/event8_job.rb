# frozen_string_literal: true

class Event8Job < EventJob
  include Sidekiq::Worker

  sidekiq_options queue: "event8"
end
