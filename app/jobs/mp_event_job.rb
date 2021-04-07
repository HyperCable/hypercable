# frozen_string_literal: true

class MpEventJob
  include Sidekiq::Worker

  COLUMN_NAMES = Hyper::Event.column_names

  def perform(*args)
    Thread.current[:bqmp] ||= BufferQueue.new(max_batch_size: (ENV["MAX_BATCH_SIZE"] || 50).to_i, execution_interval: (ENV["EXECUTION_INTERVAL"] || 5).to_i) do |batch|
      puts "bulk insert #{batch.size} records"
      Hyper::Event.insert_all!(batch)
    end
    params, form, request = args

    api_secret = params["api_secret"]
    return if api_secret.nil?
    _firebase_app_id = params["firebase_app_id"]

    meta_path = request["path"].match(/\/(?<uuid>.*?)\/mp\/collect/)
    site_uuid = meta_path["uuid"]
    return if site_uuid.nil?
    return unless RedisClient.get(api_secret) == site_uuid
    payload = JSON.parse(form)
    events = payload["events"]
    _app_instance_id = payload["app_instance_id"]
    client_id = payload["client_id"]
    user_id = payload["user_id"]
    _time = payload["timestamp_micros"]
    user_props = payload["user_properties"]
    tracking_id = params["measurement_id"]

    events.each do |event|
      tech_info = TechDetector.detect(request["user_agent"])
      tech_info.delete(:is_bot)
      real_ip = request["x_forwarded_for"] || request["ip"]
      ip_info = IPDB.get(real_ip)

      referrer_source = RefererSourceDetector.detect(params["dr"])
      traffic_info = TrafficDetector.detect({ "dl" => params["dl"], "dr" => params["dr"] })

      result = {}
      result.merge!(traffic_info)
      result.merge!(tech_info)
      result.merge!({
        site_id: site_uuid,
        event_name: event["name"],
        session_id: client_id,
        client_id: client_id,
        user_id: user_id,
        tracking_id: tracking_id,
        started_at: Time.now,

        protocol_version: "2",
        data_source: "web",

        title: params["dt"],
        user_agent: request["user_agent"],
        ip: real_ip,
        referrer: params["dr"],
        referrer_source: referrer_source,
        screen_resolution: params["sr"],
        user_language: params["ul"],

        country: ip_info[:country_name],
        city: ip_info[:city],
        region: ip_info[:region_name],
        latitude: ip_info[:latitude],
        longitude: ip_info[:longitude],

        user_props: user_props,
        event_props: event["params"],

        raw_event: event
      })
      Thread.current[:bqmp].push result
    end
  end
end
