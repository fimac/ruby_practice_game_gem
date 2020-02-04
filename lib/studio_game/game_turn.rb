
module StudioGame
  require_relative 'die'
  require_relative 'player'
  require_relative 'treasure_trove'

  module GameTurn
    def self.take_turn(player)
      die = Die.new
      number_rolled = die.roll
      treasure = TreasureTrove.random

      player.found_treasure(treasure)

      case number_rolled
      when 1..2
        player.blam
      when 3..4
        puts "#{player.name} was skipped."
      else
        player.woot
      end
    end
  end
end