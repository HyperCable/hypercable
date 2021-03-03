# frozen_string_literal: true

class SitesController < ApplicationController
  layout "auth"


  def new
    @site = current_user.sites.new
  end

  def create
    @site = current_user.sites.new(site_params)
    if @site.save
      @site.reload
      redirect_to snippet_site_path(@site), success: "site created"
    else
      render "new"
    end
  end

  def index
    @sites = current_user.sites
    render "index", layout: "application"
  end

  def show
    @site = current_user.sites.find_by!(uuid: params[:id])
    range = time_range(@site, params[:period])
    base = Hyper::Event.filter_by_params(filter_keys, params).where(site_id: params[:id]).where(started_at: range)
    current_range = time_range(@site, "realtime")
    @current_visitors_count = Hyper::Event.where(site_id: params[:id]).where(started_at: current_range).distinct.count(:client_id)
    @unique_visitors_summary = base.distinct.count(:client_id)
    @total_pageviews_summary = base.where(event_name: :page_view).count
    @avg_engagement_time = base.where(event_name: "user_engagement").average(:engagement_time)
    @new_visitors_count = base.where(event_name: "first_visit").count

    @visitors_count = base.group(group_sql).distinct.count(:client_id)
    @top_pages = base.select("location_url, count(distinct client_id) as count").group("site_id, location_url").order("2 desc").limit(9)
    query_devices(base)
    query_sources(base)
    @top_countries = base
      .where("country is not null")
      .select("country, count(distinct client_id) as count")
      .group("country")
      .map { |agg| [Hyper::Event.country_full_to_3(agg.country), agg.count] }.to_json
    render "show", layout: "application"
  end

  def debug
    @site = current_user.sites.find_by!(uuid: params[:id])
    @events = Hyper::Event.where(site_id: @site.uuid).order("started_at desc").limit(20)
    render "debug", layout: "application"
  end

  def snippet
    @site = current_user.sites.find_by!(uuid: params[:id])
  end

  def site_params
    params.require(:site).permit(:domain, :tracking_id, :timezone)
  end

  def group_sql
    case params[:period]
    when nil, "7d", "week", "30d", "month"
      "time_bucket('1 day', started_at)::date"
    when "realtime"
      "time_bucket('1 minute', started_at)::time"
    when "today"
      "time_bucket('1 hour', started_at)::time"
    when "12m", "6m"
      "time_bucket('1 day', started_at)::date"
    else
      "time_bucket('1 day', started_at)::date"
    end
  end

  def query_devices(base)
    case params[:device_meniu]
    when "device_type"
      @top_device_types = base.select("device_type, count(distinct client_id) as count").group("site_id, device_type").order("2 desc").limit(9)
    when "browser"
      @top_browsers = base.select("browser, count(distinct client_id) as count").group("site_id, browser").order("2 desc").limit(9)
    when "os"
      @top_oses = base.select("os, count(distinct client_id) as count").group("site_id, os").order("2 desc").limit(9)
    else
      @top_device_types = base.select("device_type, count(distinct client_id) as count").group("site_id, device_type").order("2 desc").limit(9)
    end
  end

  def query_sources(base)
    case params[:source_meniu]
    when "referrer_source"
      @top_referrer_sources = base.where(traffic_medium: "referral").select("referrer_source, count(distinct client_id) as count").group("site_id, referrer_source").order("2 desc").limit(9)
    when "traffic_medium"
      @top_traffic_mediums = base.select("traffic_medium, count(distinct client_id) as count").group("site_id, traffic_medium").order("2 desc").limit(9)
    when "traffic_source"
      @top_traffic_sources = base.select("traffic_source, count(distinct client_id) as count").group("site_id, traffic_source").order("2 desc").limit(9)
    when "traffic_campaign"
      @top_traffic_campaigns = base.select("traffic_campaign, count(distinct client_id) as count").group("site_id, traffic_campaign").order("2 desc").limit(9)
    else
      @top_referrer_sources = base.where(traffic_medium: "referral").select("referrer_source, count(distinct client_id) as count").group("site_id, referrer_source").order("2 desc").limit(9)
    end
  end
end
