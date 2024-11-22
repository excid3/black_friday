# frozen_string_literal: true

require_relative "black_friday/version"
require "active_support/isolated_execution_state"
require "active_support/core_ext/array/wrap"
require "active_support/core_ext/numeric/time"

module BlackFriday
  extend self

  class Error < StandardError; end

  mattr_accessor :sales, default: {}

  def add_sale(name = :black_friday, &block)
    sales[name] = block
  end

  def active?(*sale_names)
    blocks = sale_names.empty? ? sales.values : sales.values_at(*sale_names).compact
    Array.wrap(blocks).any? do
      in_range? instance_eval(&_1)
    end
  end

  def current_sales
    sales.select do |name, block|
      in_range? instance_eval(&block)
    end
  end

  def current_sale
    current_sales.first
  end

  def in_range?(range)
    range.cover?(range.first.is_a?(Date) ? Date.today : Time.current)
  end

  def range_for(sale_name)
    instance_eval(&sales.fetch(sale_name))
  end

  # Date helpers

  def thanksgiving(year = Date.today.year)
    nov_1st = Date.new(year, 11, 1)
    first_thursday = nov_1st.thursday? ? nov_1st : nov_1st.next_occurring(:thursday)
    first_thursday + 3.weeks
  end

  def canadian_thanksgiving(year = Date.today.year)
    oct_1st = Date.new(year, 10, 1)
    first_monday = oct_1st.monday? ? oct_1st : oct_1st.next_occurring(:monday)
    first_monday + 1.weeks
  end

  def black_friday(year = Date.today.year)
    thanksgiving(year) + 1.day
  end

  def cyber_monday(year = Date.today.year)
    thanksgiving(year) + 4.days
  end
end
