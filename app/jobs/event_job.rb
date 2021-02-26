# frozen_string_literal: true

class EventJob
  include Sidekiq::Worker

  def perform(*args)
    params, form, request = args

    if form
      events = form.split("\r\n").map { |x| URI.decode_www_form(x).to_h.merge(params) }
    else
      events = [params]
    end

    events.each do |event|
      meta_path = request["path"].match(/\/(?<uuid>.*?)\/g\/collect/)
      site_uuid = meta_path["uuid"]
      next if site_uuid.nil?
      real_ip = request["x_forwarded_for"] || request["ip"]
      ip_info = IPDB.get(real_ip)
      tech_info = TechDetector.detect(request["user_agent"])
      referrer_source = RefererSourceDetector.detect(event["dr"])
      traffic_info = TrafficDetector.detect(event)
      payload_parser = PayloadParser.new(event)

      result = {}
      result.merge!(traffic_info)
      result.merge!(tech_info)
      result.merge!({
        site_id: site_uuid,
        event_name: event["en"],
        session_id: event["sid"],
        client_id: event["cid"],
        user_id: event["uid"],
        tracking_id: event["tid"],
        started_at: Time.now,

        protocol_version: event["v"],
        data_source: "web",

        session_engagement: event["seg"] == "1",
        engagement_time: event["_et"],
        session_count: event["sct"],
        request_number: event["_s"],

        title: event["dt"],
        user_agent: request["user_agent"],
        ip: real_ip,
        referrer: event["dr"],
        referrer_source: referrer_source,
        screen_resolution: event["sr"],
        user_language: event["ul"],

        country: ip_info[:country_name],
        city: ip_info[:city],
        region: ip_info[:region_name],
        latitude: ip_info[:latitude],
        longitude: ip_info[:longitude],

        user_props: payload_parser.user_props,
        event_props: payload_parser.event_props,

        raw_event: event
      })

      if event["_fv"] == "1"
        Hyper::Event.create(result.merge(event_name: "first_visit"))
      end

      if event["_ss"] == "1"
        Hyper::Event.create(result.merge(event_name: "session_start"))
      end

      Hyper::Event.create!(result)
    end
  end
end
