# frozen_string_literal: true

require_relative "black_friday/version"
require "active_support/core_ext/numeric/time"

module BlackFriday
  extend self

  class Error < StandardError; end

  def thanksgiving(year = Date.today.year)
    first_thursday(year) + 3.weeks
  end

  def black_friday(year = Date.today.year)
    thanksgiving(year) + 1.day
  end

  def cyber_monday(year = Date.today.year)
    thanksgiving(year) + 4.days
  end

  def first_thursday(year = Date.today.year)
    day = nov_1st(year)
    day.thursday? ? day : day.next_occurring(:thursday)
  end

  def nov_1st(year = Date.today.year)
    Date.new(year, 11, 1)
  end
end
