# frozen_string_literal: true

class LocationUrlsController < ApplicationController
  def index
    @site = current_user.sites.find_by!(uuid: params[:site_id])
    range = time_range(@site, params[:period])
    base = Hyper::Event.filter_by_params(filter_keys, params).where(site_id: params[:site_id]).where(started_at: range)
    current_range = time_range(@site, "realtime")
    @current_visitors_count = Hyper::Event.where(site_id: params[:id]).where(started_at: current_range).distinct.count(:client_id)
    @top_location_urls = base
      .where(event_name: "page_view")
      .select("location_url, count(distinct client_id) as visitors_count, count(*) as count, count(distinct session_id) as sessions_count")
      .group("site_id, location_url").order("2 desc").limit(100)
  end
end
