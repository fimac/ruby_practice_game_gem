module StudioGame
  require 'studio_game/player'
  require 'studio_game/treasure_trove'

  describe Player do
    before do
      $stdout = StringIO.new
      @initial_health = 50
      @player = Player.new("fiona", @initial_health)
      @score = @initial_health + @player.points
    end

    it "has a capitilized name" do
    expect(@player.name).to eq("Fiona")
    end

    it "has an initial health of 50" do
      expect(@player.health).to eq(50)
    end

    it "has a string representation" do

      @player.found_treasure(Treasure.new(:hammer, 50))
      @player.found_treasure(Treasure.new(:hammer, 50))

      expect(@player.to_s).to eq("I'm Fiona with a health = 50, points = 100, and score = 150")
    end
      
    it "computes a score as the sum of its health and points" do
      @player.found_treasure(Treasure.new(:hammer, 50))
      @player.found_treasure(Treasure.new(:hammer, 50))

      expect(@player.score).to eq(150)
    end

    it "increases health by 15 when wooted" do
      @player.woot
      expect(@player.health).to eq(65)
    end

    it "decreases health by 10 when blammed" do
      @player.blam
      expect(@player.health).to eq(40)
    end

    context "created with a default health" do
      before do
        @player = Player.new("Marvin")
      end

      it "has a health value of 100" do
        expect(@player.health).to eq(100)
      end
    end

    context "with a health greater than 100" do
      before do
        @player = Player.new("Zelda", 150)
      end

      it "is strong" do
        expect(@player).to be_strong
      end
    end

    context "with a health of 100 or less" do
      before do
        @player = Player.new("Yuki", 80)
      end

      it "is weak" do
        expect(@player).not_to be_strong   
      end
    end

    context "in a collection of players" do
      before do
        @player1 = Player.new("moe", 100)
        @player2 = Player.new("larry", 200)
        @player3 = Player.new("curly", 300)

        @players = [ @player1, @player2, @player3 ]
      end

      it "is sorted by decreasing score" do
        expect(@players.sort).to eq([@player3, @player2, @player1])
      end
    end

    it "computes points as the sum of all treasure points" do
      expect(@player.points).to eq(0)

      @player.found_treasure(Treasure.new(:hammer, 50))

      expect(@player.points).to eq(50)

      @player.found_treasure(Treasure.new(:crowbar, 400))

      expect(@player.points).to eq(450)

      @player.found_treasure(Treasure.new(:hammer, 50))

      expect(@player.points).to eq(500)
    end

    it "yields each found treasure and its total points" do
      @player.found_treasure(Treasure.new(:skillet, 100))
      @player.found_treasure(Treasure.new(:skillet, 100))
      @player.found_treasure(Treasure.new(:hammer, 50))
      @player.found_treasure(Treasure.new(:bottle, 5))
      @player.found_treasure(Treasure.new(:bottle, 5))
      @player.found_treasure(Treasure.new(:bottle, 5))
      @player.found_treasure(Treasure.new(:bottle, 5))
      @player.found_treasure(Treasure.new(:bottle, 5))
    
      yielded = []
      @player.each_found_treasure do |treasure|
        yielded << treasure
      end
    
      expect(yielded).to eq([
        Treasure.new(:skillet, 200),
        Treasure.new(:hammer, 50),
        Treasure.new(:bottle, 25)
    ])
    end
  end
end