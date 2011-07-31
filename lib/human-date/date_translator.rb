require 'date'

module HumanDate
  class DateTranslator
    attr_accessor :now_tolerance

    def translate(from, to)
      return 'now' if from == to
      total_difference_in_seconds = ((to-from) *60 * 60*24).to_i
      return 'now' if total_difference_in_seconds.abs <= now_tolerance
    end
  end
end
