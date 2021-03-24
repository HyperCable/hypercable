# frozen_string_literal: true

class Event3Job < EventJob
  include Sidekiq::Worker

  sidekiq_options queue: "event3"
end
