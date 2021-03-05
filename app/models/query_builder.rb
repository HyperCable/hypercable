# frozen_string_literal: true

class QueryBuilder
  attr_reader :scope, :site, :params, :result

  FILTER_KEYS = %w[browser device_type os location_url traffic_source traffic_medium traffic_campaign referrer_source country]

  def initialize(scope, site, params)
    @scope = scope
    @site = site
    @params = params
  end

  def call
    peroid = params[:peroid]
    @result = scope
    @result = @result.where(site_id: site.uuid)
    FILTER_KEYS.each do |key|
      if params[key].present?
        @result = @result.where(key => params[key])
      end
    end
    @result = @result.where(started_at: time_period(peroid))
    @result
  end

  def time_period(peroid)
    return (7.days.ago.in_time_zone(site.timezone).to_s(:db)..) if peroid.blank?

    return (30.minutes.ago.in_time_zone(site.timezone).to_s(:db)..) if peroid == "realtime"
    return (Time.now.in_time_zone(site.timezone).beginning_of_day.to_s(:db)..) if peroid == "today"
    return (Time.now.in_time_zone(site.timezone).beginning_of_week.to_s(:db)..) if peroid == "week"
    return (Time.now.in_time_zone(site.timezone).beginning_of_month.to_s(:db)..) if peroid == "month"

    return (7.days.ago.in_time_zone(site.timezone).to_s(:db)..) if peroid == "7d"
    return (30.days.ago.in_time_zone(site.timezone).to_s(:db)..) if peroid == "30d"
    return (180.days.ago.in_time_zone(site.timezone).to_s(:db)..) if peroid == "6m"
    return (360.days.ago.in_time_zone(site.timezone).to_s(:db)..) if peroid == "12m"
  end

  def self.call(scope, site, params)
    instance = self.new(scope, site, params)
    instance.call
    instance
  end
end
