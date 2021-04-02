# frozen_string_literal: true

class MeasurementProtocolsController < ApplicationController
  before_action :get_site

  def create
    @mp = @site.measurement_protocols.create
    redirect_to site_measurement_protocols_path(@site)
  end

  def destroy
    @mp = @site.measurement_protocols.find(params[:id])
    @mp.destroy
    redirect_to site_measurement_protocols_path(@site)
  end

  def index
    @mps = @site.measurement_protocols
  end

  def get_site
    @site = current_user.sites.find_by!(uuid: params[:site_id])
  end
end
