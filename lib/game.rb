# The class game will allow you to play hangman
class Game
  def initialize(player_name, words)
    @player_name = player_name
    @words = words
    @lives = 5
  end

  def filter_words
    word_list = []
    @words.each do |word|
      word_list << word if word.length > 5 && word.length < 12
    end
    @words = word_list
  end

  def generate_word
    puts filter_words[rand(@words.length)]
  end
end
