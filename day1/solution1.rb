require_relative 'calibration_values_summarizer.rb'

class Solution1 < CalibrationValuesSummarizer
  private
  
  def parse_calibration_value(line)
    numbers_in_line = line.scan(/\d/)

    "#{numbers_in_line[0]}#{numbers_in_line[-1]}".to_i
  end
end

print Solution1.call