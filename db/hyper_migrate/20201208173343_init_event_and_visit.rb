class InitEventAndVisit < ActiveRecord::Migration[6.1]
  def change
    enable_extension("timescaledb")
    create_table :visits, id: false do |t|
      t.string :visit_token
      t.string :visitor_token

      # the rest are recommended but optional
      # simply remove any you don't want

      t.string :visitor_id

      # standard
      t.string :ip
      t.text :user_agent
      t.text :referrer
      t.string :referring_domain
      t.text :landing_page

      # technology
      t.string :browser
      t.string :os
      t.string :device_type

      # location
      t.string :country
      t.string :region
      t.string :city
      t.float :latitude
      t.float :longitude

      # utm parameters
      t.string :utm_source
      t.string :utm_medium
      t.string :utm_term
      t.string :utm_content
      t.string :utm_campaign

      # native apps
      t.string :app_version
      t.string :os_version
      t.string :platform

      t.datetime :started_at
    end

    create_table :events, id: false do |t|
      t.string :visit_token
      t.string :user_id

      t.string :name
      t.jsonb :properties
      t.datetime :time
    end
    execute "SELECT create_hypertable('visits', 'started_at');"
    execute "SELECT create_hypertable('events', 'time');"
  end
end
