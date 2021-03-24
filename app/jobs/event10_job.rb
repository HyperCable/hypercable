# frozen_string_literal: true

class Event10Job < EventJob
  include Sidekiq::Worker

  sidekiq_options queue: "event10"
end
