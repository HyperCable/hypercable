# frozen_string_literal: true

class Event9Job < EventJob
  include Sidekiq::Worker

  sidekiq_options queue: "event9"
end
