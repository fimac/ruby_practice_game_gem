module StudioGame
  module Playable
    def blam
      self.health -= 10
      puts"#{name} got blammed!"
    end

    def woot
      self.health += 15
      puts "#{name} got wooted"
    end

    def strong?
      health > 100
    end
  end
end