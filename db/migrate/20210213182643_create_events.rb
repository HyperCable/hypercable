class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events, id: false do |t|
      t.string :event_name, default: 'page_view'
      t.string :site_id, null: false

      t.string :session_id, null: false
      t.string :client_id, null: false
      t.string :user_id
      t.string :tracking_id, null: false

      t.string :protocol_version, default: '2'
      t.string :data_source, default: 'web'

      t.boolean :session_engagement, default: false
      t.integer :engagement_time
      t.integer :session_count
      t.integer :request_number

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

      t.json :user_props
      t.json :event_props

      t.boolean :non_interaction_hit, default: false

      t.datetime :started_at, null: false

      t.json :raw_event
    end

    add_index :events, [:site_id, :session_id, :started_at]
  end
end
