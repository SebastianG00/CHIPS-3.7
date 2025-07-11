class WordGuesserGame
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  #Creating getters and setters
  attr_accessor :word, :guesses, :wrong_guesses

  def guess(letter)
    #base casee that letter/char is empty, nil or is not alphabetical char
    
    if letter.nil? or letter.empty? or letter.match?(/[^A-Za-z]/)
      raise ArgumentError
    end 

    lowerCase = letter.downcase

    if @guesses.include?(lowerCase) or @wrong_guesses.include?(lowerCase)
      print("Letter already used or is not correct")
      return false
    end

    if @word.include?(lowerCase) == false
      @wrong_guesses += lowerCase
    else
      @guesses += lowerCase
    
    end

    #otherwise return true
    return true
  end
      

  def word_with_guesses
    #loop through each char in word,
    #if letter is in @gueeses we include it, else we replace it with the -

    answer = ""
    #In RUBY map cannot directly iterate iver a string, bc in Ruby a string is not an enumerable of characters
    @word.chars.map do |char|
      if @guesses.include?(char)
        answer += char
      else
        answer += "-"
      end
    end

    return answer
  end

  def check_win_or_lose
    if @wrong_guesses.length >= 7
      return :lose
    elsif @word == self.word_with_guesses
      return :win
    else
      return :play
    end
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start do |http|
      return http.post(uri, "").body
    end
  end
end
