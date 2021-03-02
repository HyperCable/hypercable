# frozen_string_literal: true

module ApplicationHelper
  def disable_with_spinner(text)
    spinner = <<~SPINNER
      <svg class="animate-spin mr-1 h-4 w-4 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
        <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
        <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
      </svg>
    SPINNER
    [spinner, text].join.html_safe
  end

  def collector_server_url(site)
    ["https://", ENV["COLLECTOR_HOST"] || ENV["HOST"], "/", site.uuid].join
  end

  def url_to_path(url)
    return if url.blank?
    URI.parse(url).normalize.request_uri
  end

  def pretty_num(num)
    number_to_human(num, format: "%n%u", units: { thousand: "K", million: "M", billion: "B" })
  end

  def domain_icon_url(domain)
    "https://icons.duckduckgo.com/ip3/#{domain}.ico"
  end

  def time_range_names
    map = {
      "today"      => "Today",
      "week"       => "Week",
      "month"      => "Month",
      "7d"         => "Last 7 days",
      "30d"        => "Last 30 days",
      "6m"         => "Last 6 months",
      "12m"        => "Last 12 months",
      "realtime"   => "Realtime",
    }
    map.default = "Last 7 days"
    map
  end

  def render_devices
    case params[:device_meniu]
    when "device_type"
      render partial: "shared/devices/device_type"
    when "browser"
      render partial: "shared/devices/browser"
    when "os"
      render partial: "shared/devices/os"
    else
      render partial: "shared/devices/device_type"
    end
  end

  def render_sources
    case params[:source_meniu]
    when "referrer_source"
      render partial: "shared/sources/referrer_source"
    when "traffic_medium"
      render partial: "shared/sources/traffic_medium"
    when "traffic_source"
      render partial: "shared/sources/traffic_source"
    when "traffic_campaign"
      render partial: "shared/sources/traffic_campaign"
    else
      render partial: "shared/sources/referrer_source"
    end
  end

  def source_tab_class(tab_name)
    if (tab_name.to_s == params[:source_meniu]) || (params[:source_meniu].blank? && tab_name.to_s == "referrer_source")
      "inline-block h-5 text-indigo-700 dark:text-indigo-500 font-bold border-b-2 border-indigo-700 dark:border-indigo-500"
    else
      "hover:text-indigo-600 cursor-pointer"
    end
  end

  def device_tab_class(tab_name)
    if (tab_name.to_s == params[:device_meniu]) || (params[:device_meniu].blank? && tab_name.to_s == "device_type")
      "inline-block h-5 text-indigo-700 dark:text-indigo-500 font-bold border-b-2 border-indigo-700 dark:border-indigo-500"
    else
      "hover:text-indigo-600 cursor-pointer"
    end
  end
end
