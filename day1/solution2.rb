require_relative 'calibration_values_summarizer.rb'

class Solution2 < CalibrationValuesSummarizer
  private
  
  NUMBERS = {
    one: 1,
    two: 2,
    three: 3,
    four: 4,
    five: 5,
    six: 6,
    seven: 7,
    eight: 8,
    nine: 9
  }
  
  def parse_calibration_value(line)
    regex = Regexp.new(NUMBERS.keys.join('|') + '|' + '\d')
    
    first_digit = find_first_digit(line, regex)
    last_digit = find_last_digit(line, regex)

    "#{first_digit}#{last_digit}".to_i
  end

  def find_first_digit(line, regex)
    matches = line.scan(regex)
      
    convert_match_to_digit(matches[0])
  end

  def find_last_digit(line, regex)
    index = -1

    loop do
      matches = line[index..-1].scan(regex)
      return convert_match_to_digit(matches[0]) if matches.any?
       
      index -= 1
    end
  end

  def convert_match_to_digit(string_or_digit)
    NUMBERS[string_or_digit.to_sym] || string_or_digit
  end
end

print Solution2.call