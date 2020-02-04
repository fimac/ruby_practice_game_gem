module StudioGame
  require_relative 'player'
  require_relative 'die'
  require_relative 'game_turn'
  require_relative 'treasure_trove'

  class Game
    attr_reader :title

    def initialize(title)
      @title = title
      @players = []
    end

    def add_player(player)
      @players << player
    end

    def save_high_scores(file="high_scores.txt")
      File.open(file, "w") do |file| 
        file.puts "#{@title} High Scores:"
        @players.sort.each do |p|
          file.puts format_high_score(p)
        end
      end
    end

    def print_name_and_health(player)
      puts "#{player.name} (#{player.health})"
    end

    def print_stats()
      strong, weak = @players.partition{|player| player.strong? }

      puts "\n#{@title} Statistics:"

      puts "\n#{strong.length} strong players:"
      strong.each{ |s| print_name_and_health(s)}

      puts "\n#{weak.length} weak players:"
      weak.each { |w| print_name_and_health(w)}

      puts "\nHigh Scores:"
      @players.sort.each do |p|
        puts format_high_score(p)
      end

      @players.each do |p|

        puts "\n#{p.name}'s point totals:"
        p.each_found_treasure do |t|
          puts "#{t.points} total #{t.name} points"
        end
        puts "#{p.points} grand total points"

      end

      puts "\n#{total_points} points from treasures found"
    end

    def format_high_score(player)
      "#{player.name}".ljust(20, ".") + "#{player.score}"
    end

    def play(rounds)
      treasures = TreasureTrove::TREASURES

      puts "There are #{treasures.length} treasures to be found:"

      treasures.each{ |t| puts "A #{t.name} is worith #{t.points}"}

      puts "There are #{@players.length} in the #{title}:"
      @players.each do |player|
        puts player
      end
      1.upto(rounds) do |round|
        if block_given?
          break if yield
        end
        puts "\nRound: #{round}"
        @players.each do |player|
          GameTurn.take_turn(player)
          puts player
        end
      end
    end

    def total_points
      @players.reduce(0) do |sum, p|
        sum + p.points
      end
    end

    def load_players(file)
      File.readlines(file).each do |line|
      add_player(Player.from_csv(line))
      end
    end
  end
end
