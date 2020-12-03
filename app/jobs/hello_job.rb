class HelloJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts args
    Rails.logger.info args.inspect
  end
end
