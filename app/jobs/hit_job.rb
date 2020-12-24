# frozen_string_literal: true

class HitJob
  include Sidekiq::Worker

  def perform(*args)
    form, request = args
    p form
    p "------"
    p request

    events = FastJsonparser.parse(form["events_json"], symbolize_keys: false)

    events.each do |event|
      url = event["properties"]["url"] || event["properties"]["href"]
      real_ip = request["x_forwarded_for"] || request["ip"]
      ip_info = IPDB.get(real_ip)
      tech_info = TechDetector.detect(request["user_agent"])
      referer_source = RefererSourceDetector.detect(request["referer"])
      utm_info = UtmDetector.detect(url || "")

      result = {}
      result.merge!(utm_info)
      result.merge!(tech_info)
      result.merge!({
        site_id: 1,
        started_at: Time.at(event["time"]),
        name: event["name"],
        session_id: form["visit_token"],
        user_token: form["visitor_token"],

        pathname: event["properties"]["page"],
        hostname: url && URI.parse(url).host,
        ip: request["ip"],
        referer: request["referer"],
        referer_source: referer_source,
        user_agent: request["user_agent"],

        platform: "Web",

        country: ip_info[:country_name],
        city: ip_info[:city],
        latitude: ip_info[:latitude],
        longitude: ip_info[:longitude]
      })

      hit = Hyper::Hit.create(result)
      # TODO handle event & view different
      if session = Hyper::Session.where(site_id: hit.site_id, session_id: hit.session_id).order("started_at desc").first
        Hyper::Session
          .where(site_id: hit.site_id, session_id: hit.session_id)
          .where(started_at: session.started_at)
          .update_all("end_at = '#{hit.started_at.to_s(:db)}', exit_page = '#{hit.pathname}', is_bounce = false, duration = EXTRACT(EPOCH FROM (end_at - started_at)), pageviews = pageviews + 1, events = events + 1")
      else
        Hyper::Session.create(
          hit.attributes.slice(*Hyper::Hit::ATTRS).merge(
            entry_page: hit.pathname,
            exit_page: hit.pathname,
            end_at: hit.started_at,
            started_at: hit.started_at
          )
        )
      end
    end
    puts Hyper::Hit.count
    puts Hyper::Session.count
  end
end


# {"events_json"=>"[{\"name\":\"$view\",\"properties\":{\"url\":\"http://localhost:3000/\",\"title\":\"极客分享\",\"page\":\"/\"},\"time\":1607976183.145,\"id\":\"a37bd684-112e-43c6-a99c-26c9364637a4\",\"js\":true}]", "visitor_token"=>"b7586f77-d25d-479e-a4cd-2269c256830e", "authenticity_token"=>"CUA2NXv0b7+n/3d0WPiRqAfH7SxlVlU8K0J/LLS5FrQ+WRhpgUphBjO6dANO58hJLhELy6WTBdCbVfXN7CVqOg==", "visit_token"=>"b52259a6-c77c-4b90-b978-d30cd98aa0ff"}
# sidekiq_1    | "------"
# sidekiq_1    | {"ip"=>"172.29.0.1", "user_agent"=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36"}
# sidekiq_1    | 2020-12-14T20:03:05.432Z pid=1 tid=clx class=HelloJob jid=c0476c2a-f76b-4c78-833e-790782b1266b elapsed=1.019 INFO: done
