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
    current_range = time_range(@site, "realtime")
    @current_visitors_count = Hyper::Event.where(site_id: params[:id]).where(started_at: current_range).distinct.count(:client_id)
    @visitors_count = Hyper::Event.where(site_id: params[:id]).where(started_at: range).group("time_bucket('1 day', started_at)::date").distinct.count(:client_id)
    @top_pages = Hyper::Event.where(site_id: params[:id]).where(started_at: range).select("location_url, count(distinct client_id) as count").group("site_id, location_url").order("2 desc").limit(9)
    @top_device_types = Hyper::Event.where(site_id: params[:id]).where(started_at: range).select("device_type, count(distinct client_id) as count").group("site_id, device_type").order("2 desc").limit(9)
    @top_browsers = Hyper::Event.where(site_id: params[:id]).where(started_at: range).select("browser, count(distinct client_id) as count").group("site_id, browser").order("2 desc").limit(9)
    @top_oses = Hyper::Event.where(site_id: params[:id]).where(started_at: range).select("os, count(distinct client_id) as count").group("site_id, os").order("2 desc").limit(9)
    @top_referrer_sources = Hyper::Event.where(site_id: params[:id]).where(started_at: range).select("referrer_source, count(distinct client_id) as count").group("site_id, referrer_source").order("2 desc").limit(9)
    @top_utm_sources = Hyper::Event.where(site_id: params[:id]).where(started_at: range).select("utm_source, count(distinct client_id) as count").group("site_id, utm_source").order("2 desc").limit(9)
    @top_utm_mediums = Hyper::Event.where(site_id: params[:id]).where(started_at: range).select("utm_medium, count(distinct client_id) as count").group("site_id, utm_medium").order("2 desc").limit(9)
    @top_utm_campaigns = Hyper::Event.where(site_id: params[:id]).where(started_at: range).select("utm_campaign, count(distinct client_id) as count").group("site_id, utm_campaign").order("2 desc").limit(9)
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
end
