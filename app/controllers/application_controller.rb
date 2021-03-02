# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :email_verify!

  helper_method :authenticate_user!, :current_user, :user_signed_in?, :default_host, :email_verify!, :filter_keys

  def current_user
    @current_user ||= User.where(remember_token: cookies[:remember_token]).first if cookies[:remember_token]
  end

  # today
  # realtime
  # this week
  # this month

  # 7 days
  # 30 days
  # 6 month
  # 12 month
  def time_range(site, range)
    return (7.days.ago.in_time_zone(site.timezone).to_s(:db)..) if range.blank?

    return (30.minutes.ago.in_time_zone(site.timezone).to_s(:db)..) if range == "realtime"
    return (Time.now.in_time_zone(site.timezone).beginning_of_day.to_s(:db)..) if range == "today"
    return (Time.now.in_time_zone(site.timezone).beginning_of_week.to_s(:db)..) if range == "week"
    return (Time.now.in_time_zone(site.timezone).beginning_of_month.to_s(:db)..) if range == "month"

    return (7.days.ago.in_time_zone(site.timezone).to_s(:db)..) if range == "7d"
    return (30.days.ago.in_time_zone(site.timezone).to_s(:db)..) if range == "30d"
    return (180.days.ago.in_time_zone(site.timezone).to_s(:db)..) if range == "6m"
    return (360.days.ago.in_time_zone(site.timezone).to_s(:db)..) if range == "12m"
  end

  def filter_keys
    %w[browser device_type os location_url traffic_source traffic_medium traffic_campaign referrer_source country]
  end

  protected

    def default_host
      Rails.application.routes.default_url_options[:host]
    end

    def authenticate_user!
      redirect_to new_session_path, error: t("login_required") unless current_user
    end

    def email_verify!
      if current_user
        redirect_to verification_registrations_path, error: "Please verify your email" unless current_user.email_verified?
      else
        redirect_to new_session_path, error: t("login_required")
      end
    end

    def set_current_user(user, remember_me = true)
      cookies[:remember_token] = if remember_me
        {
          value: user.remember_token,
          expires: 1.year.from_now.utc
        }
      else
        {
          value: user.remember_token
        }
      end
      @current_user = user
      @current_user
    end

    def user_signed_in?
      !!current_user
    end
end
