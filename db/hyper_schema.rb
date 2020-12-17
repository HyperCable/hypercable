# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_16_101055) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "timescaledb"

  create_table "events", id: false, force: :cascade do |t|
    t.string "visit_token"
    t.string "user_id"
    t.string "name"
    t.jsonb "properties"
    t.datetime "time", null: false
    t.integer "site_id"
    t.index ["time"], name: "events_time_idx", order: :desc
  end

  create_table "hits", id: false, force: :cascade do |t|
    t.string "name"
    t.integer "site_id", null: false
    t.string "session_id", null: false
    t.string "user_token", null: false
    t.string "user_id"
    t.string "hostname"
    t.string "pathname"
    t.string "user_agent"
    t.string "ip"
    t.string "referrer"
    t.string "referrer_source"
    t.string "landing_page"
    t.string "country"
    t.string "region"
    t.string "city"
    t.float "latitude"
    t.float "longitude"
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_term"
    t.string "utm_content"
    t.string "utm_campaign"
    t.string "browser"
    t.string "os"
    t.string "device_type"
    t.string "app_version"
    t.string "os_version"
    t.string "platform"
    t.jsonb "props", default: {}
    t.datetime "started_at", null: false
    t.index ["site_id", "session_id", "started_at"], name: "index_hits_on_site_id_and_session_id_and_started_at", order: { started_at: :desc }
    t.index ["started_at"], name: "hits_started_at_idx", order: :desc
  end

  create_table "sessions", id: false, force: :cascade do |t|
    t.string "session_id", null: false
    t.integer "site_id", null: false
    t.string "visit_token", null: false
    t.string "visitor_token", null: false
    t.string "user_id"
    t.string "hostname"
    t.string "pathname"
    t.string "user_agent"
    t.string "ip"
    t.string "referrer"
    t.string "referrer_source"
    t.string "landing_page"
    t.string "country"
    t.string "region"
    t.string "city"
    t.float "latitude"
    t.float "longitude"
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_term"
    t.string "utm_content"
    t.string "utm_campaign"
    t.string "browser"
    t.string "os"
    t.string "device_type"
    t.string "app_version"
    t.string "os_version"
    t.string "platform"
    t.boolean "is_bounce", default: true
    t.string "entry_page"
    t.string "exit_page"
    t.integer "pageviews", default: 0
    t.integer "events", default: 0
    t.integer "duration", default: 0
    t.datetime "end_at", null: false
    t.datetime "started_at", null: false
    t.index ["site_id", "session_id", "started_at"], name: "index_sessions_on_site_id_and_session_id_and_started_at", order: { started_at: :desc }
    t.index ["started_at"], name: "sessions_started_at_idx", order: :desc
  end

  create_table "visits", id: false, force: :cascade do |t|
    t.string "visit_token"
    t.string "visitor_token"
    t.string "visitor_id"
    t.string "ip"
    t.text "user_agent"
    t.text "referrer"
    t.string "referring_domain"
    t.text "landing_page"
    t.string "browser"
    t.string "os"
    t.string "device_type"
    t.string "country"
    t.string "region"
    t.string "city"
    t.float "latitude"
    t.float "longitude"
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_term"
    t.string "utm_content"
    t.string "utm_campaign"
    t.string "app_version"
    t.string "os_version"
    t.string "platform"
    t.datetime "started_at", null: false
    t.integer "site_id"
    t.index ["started_at"], name: "visits_started_at_idx", order: :desc
  end

  create_table "worlds", force: :cascade do |t|
    t.string "name"
  end

end
