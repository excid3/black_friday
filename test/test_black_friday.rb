# frozen_string_literal: true

require "test_helper"

class TestBlackFriday < Minitest::Test
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
end
