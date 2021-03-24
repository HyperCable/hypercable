# frozen_string_literal: true

class Event1Job < EventJob
  include Sidekiq::Worker

  sidekiq_options queue: "event1"
end
