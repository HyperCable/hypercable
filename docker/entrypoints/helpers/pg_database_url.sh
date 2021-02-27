#!/usr/bin/env ruby
require 'uri'

# Let DATABASE_URL env take presedence over individual connection params.
if !ENV['MAIN_DATABASE_URL'].nil? && ENV['MAIN_DATABASE_URL'] != ''
  uri = URI(ENV['MAIN_DATABASE_URL'])
  puts "export POSTGRES_HOST=#{uri.host} POSTGRES_PORT=#{uri.port || 5432} POSTGRES_USERNAME=#{uri.user}"
else
  puts "export POSTGRES_PORT=5432"
end