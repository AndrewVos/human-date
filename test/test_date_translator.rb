require 'minitest/autorun'
require_relative '../lib/human-date'

class DateTranslatorTest < MiniTest::Unit::TestCase
  def setup
    @date_translator = HumanDate::DateTranslator.new
  end

  def test_that_translate_returns_now_if_dates_are_equal
    now = DateTime.now
    assert_equal 'now', @date_translator.translate(now, now)
  end

  def test_that_translate_returns_now_if_date_difference_is_within_tolerance
    from  = DateTime.parse("2011-10-23T00:00:10")
    to    = DateTime.parse("2011-10-23T00:00:20")

    @date_translator.now_tolerance = 15
    assert_equal 'now', @date_translator.translate(from, to)
    assert_equal 'now', @date_translator.translate(to, from)

    @date_translator.now_tolerance = 10
    assert_equal 'now', @date_translator.translate(from, to)
    assert_equal 'now', @date_translator.translate(to, from)

    @date_translator.now_tolerance = 9
    refute_equal 'now', @date_translator.translate(from, to)
    refute_equal 'now', @date_translator.translate(to, from)
  end

end
