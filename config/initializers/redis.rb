# frozen_string_literal: true

RedisClient = Redis.new(driver: :hiredis, url: ENV["SAAS_REDIS_URL"] || ENV["REDIS_URL"] || "redis://localhost:6379/0")
return
MeasurementProtocol.all.each do |mp|
  RedisClient.set(mp.api_secret, mp.site.uuid)
end
