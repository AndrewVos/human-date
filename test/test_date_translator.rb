require 'minitest/pride'
require 'minitest/unit'
require 'minitest/autorun'
require_relative '../lib/human-date'

class DateTranslatorTest < MiniTest::Unit::TestCase
  def setup
    @date_translator = HumanDate::DateTranslator.new
  end

  def translate to
    from = DateTime.parse("2011-10-23T00:00:00")
    to   = DateTime.parse(to)
    @date_translator.translate(from, to)
  end

  def test_translate_returns_now_if_dates_are_equal
    assert_equal "now", translate("2011-10-23T00:00:00")
  end

  def test_translate_returns_now_if_date_difference_is_within_tolerance
    @date_translator.tolerance = 15
    assert_equal "now", translate("2011-10-23T00:00:15")
    assert_equal "now", translate("2011-10-23T00:00:10")
  end

  def test_translate_returns_years
    assert_equal "1 year", translate("2012-10-22T00:00:00")
    assert_equal "2 years", translate("2013-10-22T00:00:00")
  end

  def test_translate_returns_months
    assert_equal "1 month", translate("2011-11-22T00:00:00")
    assert_equal "2 months", translate("2011-12-22T00:00:00")
  end

  def test_translate_returns_days
    assert_equal "1 day", translate("2011-10-24T00:00:00")
    assert_equal "2 days", translate("2011-10-25T00:00:00")
  end

  def test_translate_returns_hours
    assert_equal "1 hour", translate("2011-10-23T01:00:00")
    assert_equal "2 hours", translate("2011-10-23T02:00:00")
  end

  def test_translate_returns_minutes
    assert_equal "1 minute", translate("2011-10-23T00:01:00")
    assert_equal "2 minutes", translate("2011-10-23T00:02:00")
  end

  def test_translate_returns_seconds
    @date_translator.tolerance = 0
    assert_equal "1 second", translate("2011-10-23T00:00:01")
    assert_equal "2 seconds", translate("2011-10-23T00:00:02")
  end

  def test_translate_appends_ago_if_to_is_before_from
    assert_equal "20 seconds ago", translate("2011-10-22T23:59:40")
    assert_equal "1 day ago", translate("2011-10-22T00:00:00")
  end

  def test_translate_returns_all_possible_times
    assert_equal "1 year, 2 months, 4 days, 2 hours, 5 minutes and 10 seconds", translate("2012-12-25T02:05:10")
  end

  def test_translage_only_returns_specified_values
    @date_translator.parts = [:year, :month, :day]
    assert_equal "1 year, 2 months and 4 days", translate("2012-12-25T00:00:00")
  end

end
