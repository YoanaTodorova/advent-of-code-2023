class Set
  attr_reader :red, :green, :blue

  def self.call(unparsed_set)
    new().parse(unparsed_set)
  end

  def initialize
    @red = 0
    @green = 0
    @blue = 0
  end

  def parse(unparsed_set)
    self.tap do
      regex = lambda { |color| /(?<number>\d+)(?=\s+#{Regexp.quote(color)})/ }

      %w(red green blue).each do |color|
        match = unparsed_set.match(regex.call(color))
        self.instance_variable_set("@#{color}", match['number'].to_i) if match
      end
    end
  end
end

class Game
  attr_reader :id, :sets

  def self.call(line)
    new().parse(line)
  end

  def initialize
    @sets = []
  end

  def parse(line)
    self.tap do
      _,unparsed_id, unparsed_sets = *line.match(/(\d+):(.*)/)
      @id = unparsed_id.to_i
      unparsed_sets.split(';').each do |part|
        @sets << Set.call(part)
      end
    end
  end
end


class Solution1
  attr_reader :games

  attr_accessor :red, :green, :blue
  def self.call(**args)
    new(**args).run
  end

  def initialize(red:, green:, blue:)
    @red = red
    @green = green
    @blue = blue
    @games = []
  end

  def run
    parse
    filter_games.inject(0) { |sum, game| sum + game.id }
  end

  def parse
    each_game do |unparsed_game|
      @games << Game.call(unparsed_game)
    end
  end

  def filter_games
    games.select do |game|
      game.sets.all? { |set| set.red <= red && set.green <= green && set.blue <= blue }
    end
  end

  private

  def each_game
    file_name = File.join(File.dirname(__FILE__), 'input1.txt')
    File.foreach(file_name) do |line|
      yield line
    end
  end
end

print Solution1.call(red: 12, green: 13, blue: 14)