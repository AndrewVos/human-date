require 'date'

module HumanDate
  class DateTranslator
    attr_accessor :now_tolerance

    ONE_YEAR    = 365 * 24 * 60 * 60
    ONE_MONTH   = 30 * 24 * 60 * 60
    ONE_DAY     = 24 * 60 * 60
    ONE_HOUR    = 60 * 60
    ONE_MINUTE  = 60

    def initialize
      @now_tolerance = 10
    end

    def translate(from, to)
      total_difference_in_seconds = ((to-from) * 60 * 60 * 24).to_i
      return 'now' if total_difference_in_seconds.abs <= now_tolerance

      if total_difference_in_seconds >= ONE_YEAR
        result = "#{total_difference_in_seconds / ONE_YEAR} year"
        result += 's' if total_difference_in_seconds >= (ONE_YEAR * 2)
      elsif total_difference_in_seconds >= ONE_MONTH
        result = "#{total_difference_in_seconds / ONE_MONTH} month"
        result += 's' if total_difference_in_seconds >= (ONE_MONTH * 2)
      elsif total_difference_in_seconds >= ONE_DAY
        result = "#{total_difference_in_seconds / ONE_DAY} day"
        result += 's' if total_difference_in_seconds >= (ONE_DAY * 2)
      elsif total_difference_in_seconds >= ONE_HOUR
        result = "#{total_difference_in_seconds / ONE_HOUR} hour"
        result += 's' if total_difference_in_seconds >= (ONE_HOUR * 2)
      elsif total_difference_in_seconds >= ONE_MINUTE
        result = "#{total_difference_in_seconds / ONE_MINUTE} minute"
        result += 's' if total_difference_in_seconds >= (ONE_MINUTE * 2)
      else
        result = "#{total_difference_in_seconds} second"
      end
      return result
    end

  end
end
