# frozen_string_literal: true

class EventBulkInsertJob
  include Sidekiq::Worker

  COLUMN_NAMES = Hyper::Event.column_names

  sidekiq_options(
    queue: :event_bulks,
    batch_flush_size: 20,     # Jobs will be combined when queue size exceeds 30
    batch_flush_interval: 60, # Jobs will be combined every 60 seconds
    retry: 5
  )

  def perform(group)
    puts "bulk size #{group.flatten.size}"

    Hyper::Event.import(
      COLUMN_NAMES,
      group.flatten.map { |attr| Hyper::Event.new(attr) },
      validate: false,
      timestamps: false
    )
  end
end
