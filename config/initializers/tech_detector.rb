# frozen_string_literal: true

class TechDetector
  CACHE = LruRedux::Cache.new(10000)

  def self.detect(ua, cache = true)
    if cache
      CACHE.getset(ua) { self.detect_without_cache(ua) }
    else
      self.detect_without_cache(ua)
    end
  end

  def self.detect_without_cache(ua)
    client = DeviceDetector.new(ua)
    device_type =
        case client.device_type
        when "smartphone"
          "Mobile"
        when "tv"
          "TV"
        else
          client.device_type.try(:titleize)
        end

    {
      browser: client.name || "unknown",
      os: client.os_name || "unknown",
      device_type: device_type || "unknown",
      is_bot: client.bot? || !client.known? || client.name == "Headless Chrome"
    }
  end
end
