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
    @date_translator.now_tolerance = 15
    assert_equal "now", translate("2011-10-23T00:00:15")
    assert_equal "now", translate("2011-10-23T00:00:10")
  end

  def test_translate_returns_years_if_time_difference_is_more_than_a_year
    assert_equal "1 year", translate("2012-10-23T00:00:00")
  end

  def test_translate_pluralizes_years_if_time_difference_is_two_years_or_more
    assert_equal "2 years", translate("2013-10-23T00:00:00")
  end

  def test_translate_returns_months_if_time_difference_is_more_than_one_month
    assert_equal "1 month", translate("2011-11-23T00:00:00")
  end

  def test_translate_pluralizes_months_if_time_difference_is_two_months_or_more
    assert_equal "2 months", translate("2011-12-23T00:00:00")
  end

  def test_translate_returns_days_if_time_difference_is_more_than_a_day
    assert_equal "1 day", translate("2011-10-24T00:00:00")
  end

  def test_translate_pluralizes_days_if_time_difference_is_two_days_or_more
    assert_equal "2 days", translate("2011-10-25T00:00:00")
  end

  def test_translate_returns_hours_if_time_difference_is_more_than_an_hour
    assert_equal "1 hour", translate("2011-10-23T01:00:00")
  end

  def test_translate_pluralizes_hours_if_time_difference_is_two_hours_or_more
    assert_equal "2 hours", translate("2011-10-23T02:00:00")
  end

  def test_translate_returns_minutes_if_time_difference_is_more_than_a_minute
    assert_equal "1 minute", translate("2011-10-23T00:01:00")
  end

  def test_translate_pluralizes_minutes_if_time_difference_is_two_minutes_or_more
    assert_equal "2 minutes", translate("2011-10-23T00:02:00")
  end

  def test_translate_returns_one_second
    @date_translator.now_tolerance = 0
    assert_equal "1 second", translate("2011-10-23T00:00:01")
  end

  def test_translate_pluralizes_seconds
    @date_translator.now_tolerance = 0
    assert_equal "2 seconds", translate("2011-10-23T00:00:02")
  end

  def test_translate_appends_ago_if_to_is_before_from
    assert_equal "20 seconds ago", translate("2011-10-22T23:59:40")
    assert_equal "1 day ago", translate("2011-10-22T00:00:00")
  end

end
