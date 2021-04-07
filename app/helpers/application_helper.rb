# frozen_string_literal: true

module ApplicationHelper
  def parent_layout(layout)
    @view_flow.set(:layout, self.output_buffer)
    self.output_buffer = render(template: layout)
  end

  def disable_with_spinner(text)
    spinner = <<~SPINNER
      <svg class="animate-spin mr-1 h-4 w-4 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
        <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
        <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
      </svg>
    SPINNER
    [spinner, text].join.html_safe
  end

  def pretty_time(num)
    return "N/A" if num.nil?
    duration = ActiveSupport::Duration.build(num.to_i).parts
    { years: "Y",
      months: "M",
      weeks: "W",
      days: "D",
      hours: "h",
      minutes: "m",
      seconds: "s"
    }.map do |part, unit|
      duration.has_key?(part) ? "#{duration[part]}#{unit}" : nil
    end.compact.join(" ")
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

  def render_setting_nav_css(tab_name)
    current = "cursor-default text-gray-900 dark:text-gray-100 rounded-md bg-gray-100 dark:bg-gray-900 hover:text-gray-900 hover:bg-gray-100 outline-none focus:outline-none focus:bg-gray-200 dark:focus:bg-gray-800"
    none_current = "text-gray-600 dark:text-gray-400 rounded-md hover:text-gray-900 dark:hover:text-gray-100 hover:bg-gray-50 dark:hover:bg-gray-800 outline-none focus:outline-none focus:text-gray-900 focus:bg-gray-50 dark:focus:text-gray-100 dark:focus:bg-gray-800"
    return current if params[:controller] == "settings" && params[:action] == "general" && tab_name.to_s == "general"
    return current if params[:controller] == "site_connections" && params[:action] == "index" && tab_name.to_s == "site_connection"
    return current if params[:controller] == "measurement_protocols" && params[:action] == "index" && tab_name.to_s == "measurement_protocol"

    none_current
  end
end
