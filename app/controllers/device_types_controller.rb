# frozen_string_literal: true

class DeviceTypesController < ApplicationController
  layout "detail"

  def index
    @site = current_user.sites.find_by!(uuid: params[:site_id])

    base = QueryBuilder.call(Hyper::Event, @site, params).result
    current_scope = QueryBuilder.call(Hyper::Event, @site, period: "realtime").result
    @current_visitors_count = current_scope.distinct.count(:client_id)
    @top_device_types = base
      .where(event_name: "page_view")
      .select("device_type, count(distinct client_id) as visitors_count, count(*) as count, count(distinct session_id) as sessions_count")
      .group("site_id, device_type").order("2 desc").limit(100)
  end
end
