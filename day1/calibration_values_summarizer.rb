class CalibrationValuesSummarizer
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
        calibration_value = parse_calibration_value(line)
        
        y << calibration_value
      end
    end
  end

  def parse_calibration_value(line)
    raise Error("Not implemented")
  end

  def each_input_line
    file_name = File.join(File.dirname(__FILE__), 'input1.txt')
    File.foreach(file_name) do |line|
      yield line
    end
  end
end