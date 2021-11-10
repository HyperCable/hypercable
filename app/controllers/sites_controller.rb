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
    query_builder = QueryBuilder.call(Hyper::Event, @site, params)
    base = query_builder.result
    previous_base = query_builder.previous_result
    current_scope = QueryBuilder.call(Hyper::Event, @site, period: "realtime").result

    @current_visitors_count = current_scope.distinct.count(:client_id)

    @unique_visitors_summary = base.distinct.count(:client_id)
    @unique_visitors_summary_p = previous_base.distinct.count(:client_id)

    @total_pageviews_summary = base.where(event_name: :page_view).count
    @total_pageviews_summary_p = previous_base.where(event_name: :page_view).count

    @avg_engagement_time = base.where(event_name: "user_engagement").select("sum(engagement_time) / count(distinct session_id) as avg_engagement_time")[0]["avg_engagement_time"]
    @avg_engagement_time_p = previous_base.where(event_name: "user_engagement").select("sum(engagement_time) / count(distinct session_id) as avg_engagement_time")[0]["avg_engagement_time"]

    @new_visitors_count = base.where(event_name: "first_visit").count
    @new_visitors_count_p = previous_base.where(event_name: "first_visit").count

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
      "DATE_FORMAT(started_at, '%Y-%m-%d')"
    when "realtime"
      "DATE_FORMAT(started_at, '%Y-%m-01 %h:%i')"
    when "today"
      "DATE_FORMAT(started_at, '%Y-%m-01 %h')"
    when "12m", "6m"
      "DATE_FORMAT(started_at, '%Y-%m-%d')"
    else
      "DATE_FORMAT(started_at, '%Y-%m-%d')"
    end
  end

  def query_devices(base)
    case params[:device_meniu]
    when "device_type"
      @top_device_types = base.where(event_name: :page_view).select("device_type, count(distinct client_id) as count").group("site_id, device_type").order("2 desc").limit(9)
    when "browser"
      @top_browsers = base.where(event_name: :page_view).select("browser, count(distinct client_id) as count").group("site_id, browser").order("2 desc").limit(9)
    when "os"
      @top_oses = base.where(event_name: :page_view).select("os, count(distinct client_id) as count").group("site_id, os").order("2 desc").limit(9)
    else
      @top_device_types = base.where(event_name: :page_view).select("device_type, count(distinct client_id) as count").group("site_id, device_type").order("2 desc").limit(9)
    end
  end

  def query_sources(base)
    case params[:source_meniu]
    when "referrer_source"
      @top_referrer_sources = base.where(event_name: :page_view).where("traffic_medium != '(none)'").select("referrer_source, count(distinct client_id) as count").group("site_id, referrer_source").order("2 desc").limit(9)
    when "traffic_medium"
      @top_traffic_mediums = base.where(event_name: :page_view).select("traffic_medium, count(distinct client_id) as count").group("site_id, traffic_medium").order("2 desc").limit(9)
    when "traffic_source"
      @top_traffic_sources = base.where(event_name: :page_view).select("traffic_source, count(distinct client_id) as count").group("site_id, traffic_source").order("2 desc").limit(9)
    when "traffic_campaign"
      @top_traffic_campaigns = base.where(event_name: :page_view).select("traffic_campaign, count(distinct client_id) as count").group("site_id, traffic_campaign").order("2 desc").limit(9)
    else
      @top_referrer_sources = base.where(event_name: :page_view).where("traffic_medium != '(none)'").select("referrer_source, count(distinct client_id) as count").group("site_id, referrer_source").order("2 desc").limit(9)
    end
  end
end
