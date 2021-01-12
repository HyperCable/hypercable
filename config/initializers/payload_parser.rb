# frozen_string_literal: true

class PayloadParser
  attr_reader :params, :items, :user_props, :event_props

  EVENT_PROP_KEY = /^ep(?<is_number>n)?\.(?<key>\w+)(\.(?<ext>\w+))?$/
  USER_PROP_KEY  = /^up(?<is_number>n)?\.(?<key>\w+)(\.(?<ext>\w+))?$/
  ITEMS_KEY = /^pr(?<index>\d+)$/

  # https://developers.google.com/gtagjs/reference/ga4-events
  KEYS = {
    item_id: :id,
    item_name: :nm,
    quantity: :qt,
    affiliation: :af,
    coupon: :cp,
    discount: :ds,
    item_brand: :br,
    item_category: :ca,
    item_category2: :ca2,
    item_category3: :ca3,
    item_category4: :ca4,
    item_category5: :ca5,
    item_variant: :va,
    price: :pr,
    item_list_name: :ln,
    item_list_id: :li,
    list_position: :lp,
    promotion_id: :pi,
    promotion_name: :pn,
    creative_name: :cn,
    creative_slot: :cs,
    location_id: :lo,
    k0: :k0,
    v0: :v0,
    k1: :k1,
    v1: :v1,
    k2: :k2,
    v2: :v2,
    k3: :k3,
    v3: :v3,
  }

  NUMBERS = %i[quantity discount price]

  KEYS_INVERT = KEYS.invert
  KEYS_REG = KEYS.values.join("|")

  def initialize(params)
    @params      = params
    @items       = []
    @user_props  = {}
    @event_props = {}
    parse!
  end

  # TODO item list name fix
  def parse!
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

      if items_key_matched = key.match(ITEMS_KEY)
        items[items_key_matched[:index].to_i - 1] = to_item_hash(value)
        next
      end
    end
    event_props["items"] = items if %w[add_payment_info add_shipping_info add_to_cart add_to_wishlist begin_checkout purchase refund remove_from_cart select_item select_promotion view_cart view_item view_item_list view_promotion].include?(params["en"])
  end

  def to_item_hash(string)
    result = {}
    scanner = StringScanner.new(string)
    KEYS.each do |_, _|
      segment = scanner.scan(/(#{KEYS_REG})([^~]|(?:~~))*(?:$|~(?=#{KEYS_REG}))/)
      next unless segment
      matched = segment.match(/^(#{KEYS_REG})(.*?)~?$/)
      next if matched[1].nil? || matched[2].nil?
      result[KEYS_INVERT[matched[1].to_sym]] = NUMBERS.include?(KEYS_INVERT[matched[1].to_sym) ? matched[2].gsub("~~", "~").to_f  : matched[2].gsub("~~", "~")
    end

    (0..3).each do |i|
      if key = result.delete("k#{i}".to_sym)
        result[key] = result.delete("v#{i}")
      end
    end
    result
  end
end
