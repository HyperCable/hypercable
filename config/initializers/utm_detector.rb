# frozen_string_literal: true

require "addressable/uri"

class UtmDetector
  def self.detect(url)
    values = Addressable::URI.parse(url).query_values || {}
    values.slice(*%w(utm_source utm_medium utm_term utm_content utm_campaign))
  end
end
