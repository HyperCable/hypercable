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

ActiveRecord::Schema.define(version: 2021_04_04_121858) do

  create_table "events", id: false, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "event_name", default: "page_view"
    t.string "site_id", null: false
    t.string "session_id", null: false
    t.string "client_id", null: false
    t.string "user_id"
    t.string "tracking_id", null: false
    t.string "protocol_version", default: "2"
    t.string "data_source", default: "web"
    t.boolean "session_engagement", default: false
    t.integer "engagement_time"
    t.integer "session_count"
    t.integer "request_number"
    t.string "location_url"
    t.string "hostname"
    t.string "path"
    t.string "title"
    t.string "user_agent"
    t.string "ip"
    t.string "referrer"
    t.string "referrer_source"
    t.string "screen_resolution"
    t.string "user_language"
    t.string "country"
    t.string "region"
    t.string "city"
    t.float "latitude"
    t.float "longitude"
    t.string "browser"
    t.string "os"
    t.string "device_type"
    t.json "user_props"
    t.json "event_props"
    t.datetime "started_at", null: false
    t.json "raw_event"
    t.string "traffic_campaign"
    t.string "traffic_medium"
    t.string "traffic_source"
    t.json "request_params"
    t.index ["site_id", "session_id", "started_at"], name: "index_events_on_site_id_and_session_id_and_started_at"
  end

  create_table "goals", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "site_id"
    t.string "event_name"
    t.string "path"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["site_id"], name: "index_goals_on_site_id"
    t.index ["user_id"], name: "index_goals_on_user_id"
  end

  create_table "measurement_protocols", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "site_id"
    t.string "api_secret", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["site_id"], name: "index_measurement_protocols_on_site_id"
  end

  create_table "shared_links", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "site_id"
    t.string "slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["site_id"], name: "index_shared_links_on_site_id"
    t.index ["slug"], name: "index_shared_links_on_slug", unique: true
  end

  create_table "site_connections", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "site_id"
    t.string "password", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["site_id"], name: "index_site_connections_on_site_id"
  end

  create_table "site_members", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "site_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["site_id", "user_id"], name: "index_site_members_on_site_id_and_user_id", unique: true
  end

  create_table "sites", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.string "tracking_id"
    t.string "timezone"
    t.boolean "public", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "domain"
    t.string "uuid", null: false
    t.index ["tracking_id"], name: "index_sites_on_tracking_id", unique: true
    t.index ["user_id"], name: "index_sites_on_user_id"
    t.index ["uuid"], name: "index_sites_on_uuid", unique: true
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest"
    t.string "remember_token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "email_verified", default: false
    t.string "email_verification_token"
    t.index ["remember_token"], name: "index_users_on_remember_token", unique: true
  end

end
