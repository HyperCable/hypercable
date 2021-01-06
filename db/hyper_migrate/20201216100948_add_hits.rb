class AddHits < ActiveRecord::Migration[6.1]
  def change
    enable_extension("timescaledb")
    create_table :hits, id: false do |t|
      t.string :event_name, default: 'page_view'
      t.integer :site_id, null: false

      t.string :session_id, null: false
      t.string :client_id, null: false
      t.string :user_id
      t.string :tracking_id, null: false

      t.string :protocol_version, default: '2'
      t.string :data_source, default: 'web'

      # standard
      t.string :location_url
      t.string :hostname
      t.string :path
      t.string :title
      t.string :user_agent
      t.string :ip
      t.string :referrer
      t.string :referrer_source
      t.string :screen_resolution
      t.string :user_language

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

      # technology
      t.string :browser
      t.string :os
      t.string :device_type

      # native apps
      t.string :app_version
      t.string :os_version
      t.string :platform
      t.jsonb :user_props, default: {}
      t.jsonb :event_props, default: {}

      t.boolean :non_interaction_hit, default: false

      t.datetime :started_at, null: false
    end

    create_table :sessions, id: false do |t|
      t.integer :site_id, null: false

      t.string :session_id, null: false
      t.string :client_id, null: false
      t.string :user_id
      t.string :tracking_id, null: false

      t.string :protocol_version, default: '2'
      t.string :data_source, default: 'web'

      # standard
      t.string :location_url
      t.string :hostname
      t.string :path
      t.string :title
      t.string :user_agent
      t.string :ip
      t.string :referrer
      t.string :referrer_source
      t.string :screen_resolution
      t.string :user_language

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

      # technology
      t.string :browser
      t.string :os
      t.string :device_type

      # native apps
      t.string :app_version
      t.string :os_version
      t.string :platform

      # stats
      t.string :landing_page
      t.boolean :is_bounce, default: true
      t.string :entry_page
      t.string :exit_page
      t.integer :pageviews, default: 0
      t.integer :events, default: 0
      t.integer :duration, default: 0

      t.datetime :end_at, null: false
      t.datetime :started_at, null: false
    end

    execute "SELECT create_hypertable('sessions', 'started_at');"
    execute "SELECT create_hypertable('hits', 'started_at');"

    add_index :sessions, [:site_id, :session_id, :started_at], order: {started_at: :desc}
    add_index :hits, [:site_id, :session_id, :started_at], order: {started_at: :desc}
  end
end