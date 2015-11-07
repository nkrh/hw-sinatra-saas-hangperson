class HangpersonGame
  attr_accessor :word, :guesses, :wrong_guesses
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    if letter.nil? or letter.length == 0 or /[a-zA-Z]/.match(letter).nil?
      raise ArgumentError
    end
    
    guesses = (@guesses + @wrong_guesses).downcase
    guess = letter.downcase
    
    unless guesses.include? guess
      if @word.downcase.include? letter
        @guesses += letter
      else
        @wrong_guesses += letter
      end
      return true
    else
      return false
    end
  end
  
  def word_with_guesses
    if @guesses.length.zero?
      return '-' * @word.length   
    else
      return @word.gsub(/[^#{@guesses}]/i, '-')
    end
  end
  
  def check_win_or_lose
    if @wrong_guesses.length < 7
      if !@guesses.length.zero? and @word.gsub(/[^#{@guesses}]/i, '-') == @word
        return :win
      else
        return :play
      end
    else
      return :lose
    end
  end
  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
