require_relative './lib/game'

def load_file
  File.readlines('./lib/words.txt') if File.exist? './lib/words.txt'
end

game = Game.new('Tin', load_file)
game.play_round
