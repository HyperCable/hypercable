# frozen_string_literal: true

class IPDB
  CACHE = LruRedux::Cache.new(10000)
  begin
    MMDB = GeoIP2Compat.new("/usr/local/var/GeoIP/GeoLite2-City.mmdb")
  rescue GeoIP2Compat::Error
    puts "run 'geoipupdate -d /usr/local/var/GeoIP' locally."
  end

  def self.get_from_mmdb(ip)
    MMDB.lookup(ip) || {}
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
