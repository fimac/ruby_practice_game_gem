module StudioGame
  require_relative 'playable'
  class Player
    include Playable

    require_relative 'treasure_trove'

    attr_accessor :health
    attr_accessor :name

    def initialize(name, health=100)
      @name = name.capitalize
      @health = health
      @found_treasures = Hash.new(0)
    end

    def self.from_csv(line)
      name, health = line.split(",")
      Player.new(name, Integer(health))
    end

    
    def score
      @health + points
    end

    

    def <=>(other)
      other.score <=> score
    end

    def to_s
      "I'm #{@name} with a health = #{@health}, points = #{points}, and score = #{score}"
    end

    def found_treasure(treasure)
      @found_treasures[treasure.name] += treasure.points
      puts "#{@name} found a #{treasure.name} worth #{treasure.points}"
      puts "#{@name}'s treasures: #{@found_treasures}"
    end

    def points
      @found_treasures.values.reduce(0, :+)
    end

    def each_found_treasure
      @found_treasures.each do |k, v|
        yield Treasure.new(k, v)
      end
    end
  end

  if __FILE__ == $0
    player = Player.new("Larry")
    puts player.name
    puts player.health
    player.woot
    puts player.health
    player.blam
    puts player.health
  end
end