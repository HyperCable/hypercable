# frozen_string_literal: true

class GrowthRate
  attr_reader :base_data, :new_data

  def initialize(base_data, new_data)
    @base_data = base_data.to_f
    @new_data = new_data.to_f
  end

  def growth_value
    new_data - base_data
  end

  def growth_rate
    (growth_value / base_data) * 100
  end

  def na?
    return true if base_data.zero?
    false
  end

  def positive?
    growth_value > 0
  end
end
