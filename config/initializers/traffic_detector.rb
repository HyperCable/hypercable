# frozen_string_literal: true

require "addressable/uri"

class TrafficDetector
  DEFAULT_SOURCE = "(direct)"
  DEFAULT_MEDIUM = "(none)"
  DEFAULT_CAMPAIGN = "(direct)"

  REF_PARSER = RefererParser::Parser.new("./data/referers.yml")

  def self.detect(event)
    result = {}
    request_url = event["dl"]
    request_uri = Addressable::URI.parse(request_url)
    request_params = request_uri.query_values || {}

    referrer_url = event["dr"]

    result[:hostname] = request_uri.domain
    result[:path] = request_uri.normalized_path

    if referrer_url.present?
      referrer_uri = Addressable::URI.parse(referrer_url)
      referrer_params = referrer_uri.query_values || {}
      if request_params["gclid"].present?
        result.merge!(
          traffic_campaign: "adwords",
          traffic_source: "google",
          traffic_medium: "cpc"
        )
      elsif request_params["gclsrc"].present?
        result.merge!(
          traffic_campaign: "DoubleClick",
          traffic_source: "google",
          traffic_medium: "cpc"
        )
      elsif referrer_uri.domain == request_uri.domain
        result.merge!(
          traffic_campaign: DEFAULT_CAMPAIGN,
          traffic_source: referrer_uri.domain,
          traffic_medium: "(internal)"
        )
      elsif request_params["utm_source"].present?
        result.merge!(
          traffic_campaign: request_params["utm_campaign"] || "(not set)",
          traffic_source: request_params["utm_source"],
          traffic_medium: request_params["utm_medium"] || "(not set)"
        )
      else
        ref_parser_result = REF_PARSER.parse(referrer_url)
        if ref_parser_result[:known]
          result.merge!(
            traffic_campaign: DEFAULT_CAMPAIGN,
            traffic_source: ref_parser_result[:source],
            traffic_medium: ref_parser_result[:medium]
          )
        else
          result.merge!(
            traffic_campaign: DEFAULT_CAMPAIGN,
            traffic_source: referrer_uri.domain,
            traffic_medium: "referral"
          )
        end
      end
    else
      result.merge!(
        traffic_campaign: DEFAULT_CAMPAIGN,
        traffic_source: DEFAULT_SOURCE,
        traffic_medium: DEFAULT_MEDIUM
      )
    end

    result
  end
end