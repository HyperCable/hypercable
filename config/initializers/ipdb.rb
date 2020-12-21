# frozen_string_literal: true

begin
  IPDB = GeoIP2Compat.new("/usr/local/var/GeoIP/GeoLite2-City.mmdb")
rescue GeoIP2Compat::Error
  puts "run 'geoipupdate -d /usr/local/var/GeoIP' locally."
end
