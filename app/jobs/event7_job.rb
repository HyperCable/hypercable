# frozen_string_literal: true

class Event7Job < EventJob
  include Sidekiq::Worker

  sidekiq_options queue: "event7"
end
