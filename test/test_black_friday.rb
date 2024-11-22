# frozen_string_literal: true

require "test_helper"

class TestBlackFriday < Minitest::Test
  def setup
    BlackFriday.sales.clear
  end

  def test_that_it_has_a_version_number
    refute_nil ::BlackFriday::VERSION
  end

  def test_thanksgiving
    assert_equal Date.new(2024, 11, 28), BlackFriday.thanksgiving(2024)
    assert_equal Date.new(2025, 11, 27), BlackFriday.thanksgiving(2025)
    assert_equal Date.new(2026, 11, 26), BlackFriday.thanksgiving(2026)
    assert_equal Date.new(2029, 11, 22), BlackFriday.thanksgiving(2029)
  end

  def test_black_friday
    assert_equal Date.new(2024, 11, 29), BlackFriday.black_friday(2024)
    assert_equal Date.new(2025, 11, 28), BlackFriday.black_friday(2025)
    assert_equal Date.new(2026, 11, 27), BlackFriday.black_friday(2026)
    assert_equal Date.new(2029, 11, 23), BlackFriday.black_friday(2029)
  end

  def test_cyber_monday
    assert_equal Date.new(2024, 12, 2), BlackFriday.cyber_monday(2024)
    assert_equal Date.new(2025, 12, 1), BlackFriday.cyber_monday(2025)
    assert_equal Date.new(2026, 11, 30), BlackFriday.cyber_monday(2026)
    assert_equal Date.new(2029, 11, 26), BlackFriday.cyber_monday(2029)
  end

  def test_add_sale
    block = -> {}
    BlackFriday.add_sale(&block)
    assert_equal block, BlackFriday.sales[:black_friday]
  end

  def test_active_sale
    BlackFriday.add_sale { Date.yesterday..Date.tomorrow }
    assert BlackFriday.active?
  end

  def test_inactive_sale
    BlackFriday.add_sale { Date.yesterday..Date.yesterday }
    refute BlackFriday.active?
  end

  def test_current_sales
    BlackFriday.add_sale { Date.yesterday..Date.tomorrow }
    BlackFriday.add_sale(:extra) { Date.tomorrow..Date.tomorrow }
    assert [:black_friday, :extra], BlackFriday.current_sales
  end

  def test_current_sale
    BlackFriday.add_sale { Date.yesterday..Date.tomorrow }
    assert :black_friday, BlackFriday.current_sale
  end

  def test_in_range_with_time_with_zone
    Time.zone = "Central Time (US & Canada)"
    BlackFriday.add_sale { Time.current.yesterday..Time.current.tomorrow }
    assert BlackFriday.active?
  ensure
    Time.zone = nil
  end
end
