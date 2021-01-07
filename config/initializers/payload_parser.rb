# frozen_string_literal: true

class PayloadParser
  attr_reader :params, :items, :user_props, :event_props

  EVENT_PROP_KEY = /^ep(?<is_number>n)?\.(?<key>\w+)(\.(?<ext>\w+))?$/
  USER_PROP_KEY  = /^up(?<is_number>n)?\.(?<key>\w+)(\.(?<ext>\w+))?$/
  # ITEMS_KEY = /^pr(?<index>\d+)$/
  def initialize(params)
    @params      = params
    @items       = []
    @user_props  = {}
    @event_props = {}
    parse!
  end

  def parse!
    # TODO ext
    # TODO items
    params.each do |key, value|
      if event_prop_key_matched = key.match(EVENT_PROP_KEY)
        event_props[event_prop_key_matched[:key]] = if event_prop_key_matched[:ext] == "json"
          FastJsonparser.parse(value, symbolize_keys: false)
        else
          event_prop_key_matched[:is_number] ? value.to_f : value
        end
        next
      end

      if user_prop_key_matched = key.match(USER_PROP_KEY)
        user_props[user_prop_key_matched[:key]] = if user_prop_key_matched[:ext] == "json"
          FastJsonparser.parse(value, symbolize_keys: false)
        else
          user_prop_key_matched[:is_number] ? value.to_f : value
        end
        next
      end
    end
  end
end
