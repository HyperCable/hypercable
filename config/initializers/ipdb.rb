# frozen_string_literal: true

class IPDB
  CACHE = LruRedux::Cache.new(10000)
  begin
    if Rails.env.production?
      $mmdb = GeoIP2Compat.new("/usr/share/GeoIP/GeoLite2-City.mmdb")
    else
      $mmdb = GeoIP2Compat.new("/usr/local/var/GeoIP/GeoLite2-City.mmdb")
    end
  rescue GeoIP2Compat::Error
    puts "run 'geoipupdate -d /usr/local/var/GeoIP' locally."
  end

  def self.get_from_mmdb(ip)
    return {} if $mmdb.nil?
    $mmdb.lookup(ip) || {}
  rescue GeoIP2Compat::Error
    {}
  end

  def self.get(ip, cache = true)
    if cache
      CACHE.getset(ip) { self.get_from_mmdb(ip) }
    else
      self.get_from_mmdb(ip)
    end
  end
end
