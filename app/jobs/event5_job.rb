# frozen_string_literal: true

class Event5Job < EventJob
  include Sidekiq::Worker

  sidekiq_options queue: "event5"
end
