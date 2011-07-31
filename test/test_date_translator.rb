require 'minitest/pride'
require 'minitest/unit'
require 'minitest/autorun'
require_relative '../lib/human-date'

class DateTranslatorTest < MiniTest::Unit::TestCase
  def setup
    @date_translator = HumanDate::DateTranslator.new
  end

  def setup_time from, to
    @from = DateTime.parse(from)
    @to   = DateTime.parse(to)
  end

  def test_translate_returns_now_if_dates_are_equal
    now = DateTime.now
    assert_equal 'now', @date_translator.translate(now, now)
  end

  def test_translate_returns_now_if_date_difference_is_within_tolerance
    setup_time "2011-10-23T00:00:10", "2011-10-23T00:00:20"

    @date_translator.now_tolerance = 15
    assert_equal 'now', @date_translator.translate(@from, @to)
    assert_equal 'now', @date_translator.translate(@to, @from)

    @date_translator.now_tolerance = 10
    assert_equal 'now', @date_translator.translate(@from, @to)
    assert_equal 'now', @date_translator.translate(@to, @from)

    @date_translator.now_tolerance = 9
    refute_equal 'now', @date_translator.translate(@from, @to)
    refute_equal 'now', @date_translator.translate(@to, @from)
  end

  def test_translate_returns_years_if_time_difference_is_more_than_a_year
    setup_time "2011-10-23T00:00:00", "2012-10-23T00:00:00"
    assert_equal '1 year', @date_translator.translate(@from, @to)
  end

  def test_translate_pluralizes_years_if_time_difference_is_two_years_or_more
    setup_time "2011-10-23T00:00:00", "2013-10-23T00:00:00"
    assert_equal '2 years', @date_translator.translate(@from, @to)
  end

  def test_translate_returns_months_if_time_difference_is_more_than_one_month
    setup_time "2011-10-23T00:00:00", "2011-11-23T00:00:00"
    assert_equal '1 month', @date_translator.translate(@from, @to)
  end

  def test_translate_pluralizes_months_if_time_difference_is_two_months_or_more
    setup_time "2011-10-23T00:00:00", "2011-12-23T00:00:00"
    assert_equal '2 months', @date_translator.translate(@from, @to)
  end

  def test_translate_returns_days_if_time_difference_is_more_than_a_day
    setup_time "2011-10-23T00:00:00", "2011-10-24T00:00:00"
    assert_equal '1 day', @date_translator.translate(@from, @to)
  end

  def test_translate_pluralizes_days_if_time_difference_is_two_days_or_more
    setup_time "2011-10-23T00:00:00", "2011-10-25T00:00:00"
    assert_equal '2 days', @date_translator.translate(@from, @to)
  end

  def test_translate_returns_hours_if_time_difference_is_more_than_an_hour
    setup_time "2011-10-23T00:00:00", "2011-10-23T01:00:00"
    assert_equal '1 hour', @date_translator.translate(@from, @to)
  end

  def test_translate_pluralizes_hours_if_time_difference_is_two_hours_or_more
    setup_time "2011-10-23T00:00:00", "2011-10-23T02:00:00"
    assert_equal '2 hours', @date_translator.translate(@from, @to)
  end

  def test_translate_returns_minutes_if_time_difference_is_more_than_a_minute
    setup_time "2011-10-23T00:00:00", "2011-10-23T00:01:00"
    assert_equal '1 minute', @date_translator.translate(@from, @to)
  end

  def test_translate_pluralizes_minutes_if_time_difference_is_two_minutes_or_more
    setup_time "2011-10-23T00:00:00", "2011-10-23T00:02:00"
    assert_equal '2 minutes', @date_translator.translate(@from, @to)
  end

  def test_translate_returns_one_second
    @date_translator.now_tolerance = 0
    setup_time "2011-10-23T00:00:00", "2011-10-23T00:00:01"
    assert_equal '1 second', @date_translator.translate(@from, @to)
  end

  def test_translate_pluralizes_seconds
    @date_translator.now_tolerance = 0
    setup_time "2011-10-23T00:00:00", "2011-10-23T00:00:02"
    assert_equal '2 seconds', @date_translator.translate(@from, @to)
  end

end
