# frozen_string_literal: true

class RefererSourceDetector
  CACHE = LruRedux::Cache.new(1000)

  def self.detect(referer, cache = true)
    if cache
      CACHE.getset(referer) { self.detect_without_cache(referer) }
    else
      self.detect_without_cache(ua)
    end
  end

  def self.detect_without_cache(referer)
    return nil if referer.blank?
    uri = URI.parse(referer) rescue nil
    uri&.host
  end
end
