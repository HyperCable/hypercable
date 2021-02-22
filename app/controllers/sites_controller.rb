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
    @top_pages = Hyper::Event.where(site_id: params[:id]).where(started_at: range).select("path, count(distinct client_id) as count").group("site_id, path").order("2 desc").limit(10)
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
