# frozen_string_literal: true

class SiteConnectionsController < ApplicationController
  before_action :get_site

  def create
    @site_connection = @site.site_connections.create
    redirect_to site_site_connections_path(@site)
  end

  def destroy
    @site_connection = @site.site_connections.find(params[:id])
    @site_connection.destroy
    redirect_to site_site_connections_path(@site)
  end

  def index
    @site_connections = @site.site_connections
  end

  def get_site
    @site = current_user.sites.find_by!(uuid: params[:site_id])
  end
end
