# The class game will allow you to play hangman
class Game
  def initialize(player_name, words)
    @player_name = player_name
    @words = words
    @lives = 5
    @guessed_letters = []
  end

  def filter_words
    word_list = []
    @words.each do |word|
      word_list << word if word.length > 5 && word.length < 12
    end
    @words = word_list
  end

  def generate_word
    filter_words[rand(@words.length)]
  end

  def display_word(word)
    puts word
    char_array = word.chars
    char_array.each do |char|
      if @guessed_letters.include?(char)
        print " #{char} "
      else
        print ' - '
      end
    end
    puts
  end

  def play_round
    word = generate_word
    display_word(word)
    while @lives > 0 do 
      puts "Remaining lives #{@lives}"
      puts "Guessed letters #{@guessed_letters}"
      puts "Please enter a letter"
      letter = gets.chomp
      if word.include?(letter)
        puts "The word includes the letter #{letter}"
      else
        @lives = @lives - 1
        puts "The word does not include the letter #{letter}"
      end
      @guessed_letters << letter
      display_word(word)
    end
  end
end
