require 'date'

module HumanDate
  class DateTranslator
    attr_accessor :tolerance, :parts

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
      @parts = TIME.keys
    end

    def translate from, to
      total_difference_in_seconds = ((to-from) * 60 * 60 * 24).to_i
      absolute_total_difference_in_seconds = total_difference_in_seconds.abs
      return 'now' if absolute_total_difference_in_seconds <= tolerance

      words = []
      parts.each do |key|
        if absolute_total_difference_in_seconds >= TIME[key]
          count = 0
          while absolute_total_difference_in_seconds >= TIME[key]
            absolute_total_difference_in_seconds -= TIME[key]
            count += 1
          end
          word = "#{count} #{key}"
          word += 's' if count >= 2
          words << word
        end
      end

      sentence = join_words(words)
      sentence += ' ago' if total_difference_in_seconds < 0
      sentence
    end

    private

    def join_words(words)
      if words.size > 2
        last_two_words = "#{words[-2]} and #{words[-1]}"
        words.pop
        words.pop
        words.push(last_two_words)
      end
      words.join(", ")
    end

  end
end
