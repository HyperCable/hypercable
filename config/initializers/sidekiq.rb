# frozen_string_literal: true

require "sidekiq/worker_killer"

if Sidekiq.server?
  Sidekiq.on(:startup) do
    BQ = BufferQueue.new(max_batch_size: 10, execution_interval: 100) do |batch|
      puts "bulk insert #{batch.size} records"
      Hyper::Event.import(
        EventJob::COLUMN_NAMES,
        batch.flatten.map { |attr| Hyper::Event.new(attr) },
        validate: false,
        timestamps: false
      ) unless batch.empty?
    end
  end
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV["REDIS_URL"] || "redis://localhost:6379/0" }
  config.server_middleware do |chain|
    chain.add Sidekiq::WorkerKiller, max_rss: 880
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV["REDIS_URL"] || "redis://localhost:6379/0" }
end
