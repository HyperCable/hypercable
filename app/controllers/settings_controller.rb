# frozen_string_literal: true

class SettingsController < ApplicationController
  before_action :get_site

  def general
  end

  def update_general
    @site.update(params.require(:site).permit(:timezone, :domain, :tracking_id))
    if @site.valid?
      flash[:success] = "Site update successfully."
      redirect_back fallback_location: general_site_settings_path(@site)
    else
      flash[:error] = "Site update failed"
      render "general"
    end
  end

  def visibility
  end

  def update_visibility
  end

  def get_site
    @site = current_user.sites.find_by!(uuid: params[:site_id])
  end
end
