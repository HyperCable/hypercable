# frozen_string_literal: true

class HelloJob
  include Sidekiq::Worker

  def perform(*args)
    form, request = args
    p form
    p "------"
    p request
    Rails.logger.info args.inspect
  end
end
