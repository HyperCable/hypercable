# frozen_string_literal: true

class QueryBuilder
  attr_reader :scope, :site, :params, :result, :period

  FILTER_KEYS = %w[browser device_type os location_url traffic_source traffic_medium traffic_campaign referrer_source country]

  def initialize(scope, site, params)
    @scope = scope
    @site = site
    @params = params
    @period = params[:period]
  end

  def call
    @result = scope
    @result = @result.where(site_id: site.uuid)
    FILTER_KEYS.each do |key|
      if params[key].present?
        @result = @result.where(key => params[key])
      end
    end
    @result = @result.where(started_at: time_period)
    @result
  end

  def time_period
    return (7.days.ago.in_time_zone(site.timezone).to_s(:db)..) if period.blank?

    return (30.minutes.ago.in_time_zone(site.timezone).to_s(:db)..) if period == "realtime"
    return (Time.now.in_time_zone(site.timezone).beginning_of_day.to_s(:db)..) if period == "today"
    return (Time.now.in_time_zone(site.timezone).beginning_of_week.to_s(:db)..) if period == "week"
    return (Time.now.in_time_zone(site.timezone).beginning_of_month.to_s(:db)..) if period == "month"

    return (7.days.ago.in_time_zone(site.timezone).to_s(:db)..) if period == "7d"
    return (30.days.ago.in_time_zone(site.timezone).to_s(:db)..) if period == "30d"
    return (180.days.ago.in_time_zone(site.timezone).to_s(:db)..) if period == "6m"
    return (360.days.ago.in_time_zone(site.timezone).to_s(:db)..) if period == "12m"
  end

  def prev_period
    return (14.days.ago.in_time_zone(site.timezone).to_s(:db)...7.days.ago.in_time_zone(site.timezone).to_s(:db)) if period.blank?

    return (60.minutes.ago.in_time_zone(site.timezone).to_s(:db)...30.minutes.ago.in_time_zone(site.timezone).to_s(:db)) if period == "realtime"
    return (1.day.ago.in_time_zone(site.timezone).beginning_of_day.to_s(:db)...Time.now.in_time_zone(site.timezone).beginning_of_day.to_s(:db)) if period == "today"
    return (1.week.ago.in_time_zone(site.timezone).beginning_of_week.to_s(:db)...Time.now.in_time_zone(site.timezone).beginning_of_week.to_s(:db)) if period == "week"
    return (1.month.ago.in_time_zone(site.timezone).beginning_of_month.to_s(:db)...Time.now.in_time_zone(site.timezone).beginning_of_month.to_s(:db)) if period == "month"

    return (14..days.ago.in_time_zone(site.timezone).to_s(:db)...7.days.ago.in_time_zone(site.timezone).to_s(:db)) if period == "7d"
    return (60.days.ago.in_time_zone(site.timezone).to_s(:db)...30.days.ago.in_time_zone(site.timezone).to_s(:db)) if period == "30d"
    return (360.days.ago.in_time_zone(site.timezone).to_s(:db)...180.days.ago.in_time_zone(site.timezone).to_s(:db)) if period == "6m"
    return (720.days.ago.in_time_zone(site.timezone).to_s(:db)...360.days.ago.in_time_zone(site.timezone).to_s(:db)) if period == "12m"
  end

  def self.call(scope, site, params)
    instance = self.new(scope, site, params)
    instance.call
    instance
  end
end
