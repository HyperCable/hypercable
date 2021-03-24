# frozen_string_literal: true

class Event2Job < EventJob
  include Sidekiq::Worker

  sidekiq_options queue: "event2"
end
