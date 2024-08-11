require 'json'

require_relative './lib/game'

def load_file
  File.readlines('./lib/words.txt') if File.exist? './lib/words.txt'
end

def load_games
  puts "Load save"
  loaded_games = JSON.parse(File.read('./lib/saved_games.json'))
  games = []
  loaded_games.each do |game_data|
    puts game_data['word']
    game = Game.new(game_data['player_name'])
    game.lives = game_data['lives']
    game.guessed_letters = game_data['guessed_letters']
    game.word = game_data['word']
    game.char_array = game_data['char_array']
    game.words = load_file
    puts game.guessed_letters
    games << game
  end
  games
end

def choose_game(games)

  games.each_with_index do |game, index|
    puts "Game #{index+1}"
    puts "Player: #{game.player_name}"
    puts "Lives: #{game.lives}"
    puts "Word:"
    game.char_array.each do |char|
      if game.guessed_letters.include?(char)
        print char
      else
        print ' - '
      end
    end
    puts
  end
  puts "Please enter a game you would like to choose"
  games[gets.chomp.to_i-1]
end

def play_hangman
  game = Game.new('Tin')
  game.words = load_file
  game.generate_word
  choice = ""
  while choice != "3"
    puts "1. Play a new round\n2. Load a save\n3. exit"
    choice = gets.chomp
    case choice
    when "1"
      save = game.play_round
      if save == 1
        existing_games = JSON.parse(File.read('./lib/saved_games.json'))
        existing_games << game.to_hash
        File.open('./lib/saved_games.json', 'w') do |f|
          f.write(existing_games.to_json)
        end
      end
    when "2"
      puts "Loading save"
      game = choose_game(load_games)
    when "3"
      puts "Exiting"
    else
      puts "Wrong input"
    end
  end
end

play_hangman