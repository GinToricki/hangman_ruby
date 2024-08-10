# The class game will allow you to play hangman
class Game
  def initialize(player_name, words)
    @player_name = player_name
    @words = words
    @lives = 5
    @guessed_letters = []
    @word = ''
    @char_array = []
  end

  def filter_words
    word_list = []
    @words.each do |word|
      word_list << word if word.length > 5 && word.length < 12
    end
    @words = word_list
  end

  def generate_word
    @word = filter_words[rand(@words.length)]
    @char_array = @word.chars
    @char_array.pop
    @word
  end

  def display_word
    @char_array.each do |char|
      if @guessed_letters.include?(char)
        print " #{char} "
      else
        print ' - '
      end
    end
    puts
  end

  def check_win
    won = true
    @char_array.each do |char|
      won = false unless @guessed_letters.include?(char)
    end
    won
  end

  def enter_letter
    puts 'Please enter a letter'
    letter = gets.chomp.downcase
    while @guessed_letters.include?(letter)
      puts "Please enter another letter. You already guessed #{letter}"
      letter = gets.chomp.downcase
    end
    if @word.include?(letter)
      puts "The word includes the letter #{letter}"
    else
      @lives -= 1
      puts "The word does not include the letter #{letter}"
    end
    @guessed_letters << letter
  end

  def play_round
    generate_word
    display_word
    while @lives > 0
      puts "Remaining lives #{@lives}"
      puts "Guessed letters #{@guessed_letters}"
      enter_letter
      display_word
      if check_win
        puts 'You win'
        break
      end
    end
    puts 'End of play round'
  end
end
