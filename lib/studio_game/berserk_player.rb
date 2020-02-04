module StudioGame
  require_relative 'player'

  class BerserkPlayer < Player
    def initialize(name, health=100)
      super(name, health)
      @woot_count = 0
    end

    def berserk?
      @woot_count > 5
    end

    def woot
      super
      @woot_count += 1
      if berserk?
        puts "Berserker is berserk!"
      end
    end

    def blam
      berserk? ? woot : super
    end
  end

  if __FILE__ == $0
    berserker = BerserkPlayer.new("berserker", 50)
    6.times { berserker.woot }
    2.times { berserker.blam }
    puts berserker.health
  end
end