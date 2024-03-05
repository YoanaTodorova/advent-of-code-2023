class Solution1
  def self.call
    new().run
  end

  def run
    calibration_values.reduce(:+)
  end
    
  private

  def calibration_values
    Enumerator.new do |y|
      each_input_line do |line|
        numbers_in_line = line.scan(/\d/)
        calibration_value = "#{numbers_in_line[0]}#{numbers_in_line[-1]}".to_i

        y << calibration_value
      end
    end
  end

  def each_input_line
    File.foreach("input1.txt") do |line|
      yield line
    end
  end
end

print Solution1.call