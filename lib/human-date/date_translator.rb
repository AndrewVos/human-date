require 'date'

module HumanDate
  class DateTranslator
    attr_accessor :tolerance

    TIME = {
      :year     => 365 * 24 * 60 * 60,
      :month    => 30 * 24 * 60 * 60,
      :day      => 24 * 60 * 60,
      :hour     => 60 * 60,
      :minute   => 60,
      :second   => 1
    }

    def initialize
      @tolerance = 1
    end

    def translate(from, to)
      total_difference_in_seconds = ((to-from) * 60 * 60 * 24).to_i
      return 'now' if total_difference_in_seconds.abs <= tolerance

      TIME.keys.each do |key|
        if total_difference_in_seconds.abs >= TIME[key]
          result = "#{total_difference_in_seconds.abs / TIME[key]} #{key}"
          result += 's' if total_difference_in_seconds.abs >= (TIME[key] * 2)
          result += ' ago' if total_difference_in_seconds < 0
          return result
        end
      end
    end

  end
end
