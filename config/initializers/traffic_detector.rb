# frozen_string_literal: true

# https://support.google.com/analytics/answer/6205762?hl=en

require "addressable/uri"

class TrafficDetector
  DEFAULT_SOURCE = "(direct)"
  DEFAULT_MEDIUM = "(none)"
  DEFAULT_CAMPAIGN = "(direct)"

  REF_PARSER = RefererParser::Parser.new("./data/referers.yml")

  def self.detect(event)
    result = {}
    request_url = event["dl"]
    return result if request_url.nil?

    request_uri = Addressable::URI.parse(request_url).normalize
    request_params = request_uri.query_values || {}

    referrer_url = event["dr"]

    result[:hostname] = request_uri.domain
    result[:path] = request_uri.path
    result[:location_url] = request_uri.to_s
    result[:request_params] = request_params

    return result.merge!(
      traffic_campaign: "adwords",
      traffic_source: "Google",
      traffic_medium: "cpc"
    ) if request_params["gclid"].present?

    return result.merge!(
      traffic_campaign: "DoubleClick",
      traffic_source: "Google",
      traffic_medium: "cpc"
    ) if request_params["gclsrc"].present?

    return result.merge!(
      traffic_campaign: request_params["utm_campaign"] || "(not set)",
      traffic_source: request_params["utm_source"],
      traffic_medium: request_params["utm_medium"] || "(not set)"
    ) if request_params["utm_source"].present?

    if referrer_url.present?
      referrer_uri = Addressable::URI.parse(referrer_url)
      if  referrer_uri.host == request_uri.host
        return result.merge!(
          traffic_campaign: "(internal)",
          traffic_source: referrer_uri.domain,
          traffic_medium: "(internal)"
        )
      else
        ref_parser_result = REF_PARSER.parse(referrer_uri.normalize.to_s)
        if ref_parser_result[:known]
          return result.merge!(
            traffic_campaign: "(not set)",
            traffic_source: ref_parser_result[:source],
            traffic_medium: ref_parser_result[:medium]
          )
        else
          return result.merge!(
            traffic_campaign: "(not set)",
            traffic_source: referrer_uri.domain,
            traffic_medium: "referral"
          )
        end
      end
    else
      return result.merge!(
        traffic_campaign: DEFAULT_CAMPAIGN,
        traffic_source: DEFAULT_SOURCE,
        traffic_medium: DEFAULT_MEDIUM
      )
    end
    result.merge!(
      traffic_campaign: DEFAULT_CAMPAIGN,
      traffic_source: DEFAULT_SOURCE,
      traffic_medium: DEFAULT_MEDIUM
    )
  end
end
