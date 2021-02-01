# frozen_string_literal: true

default = if Rails.env.development?
  "localhost:3000"
elsif Rails.env.test?
  "localhost:3000"
elsif Rails.env.production?
  "hypercable.plus"
end
Rails.application.routes.default_url_options[:host] = ENV["HOST"] || default

# NOTICE: http://lulalala.logdown.com/posts/5835445-rails-many-default-url-options
Rails.application.routes.default_url_options[:protocol] = "https" if Rails.env.production?
