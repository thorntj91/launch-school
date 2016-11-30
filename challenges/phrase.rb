require 'pry'
class Phrase

  attr_reader :phrase
  attr_accessor :occurences
  
  def initialize(phrase)
    @phrase = phrase
    @occurences = {}
  end

  def word_count
    self.occurences = {} unless occurences().empty?

    format

    word = ""
    parse_phrase(phrase) do |c|
      binding.pry
      if c == " "
        add_to_occurences(word) unless word == ""
        word = ""
      else
       word += c
      end 
    end

    add_to_occurences(word)

    binding.pry
    occurences

  end


  def add_to_occurences(word)

    word = strip_quotes(word) if word.start_with?("\'") || word.start_with?("\"")
    if occurences[word]
      occurences[word] += 1
    else
      occurences[word] = 1
    end
  end

  def strip_quotes(word)
    word.slice(1..(word.length - 2))
  end

  def parse_phrase(phrase)
    phrase.split("").each { |c| yield(c) }
  end

  private 

  def format
    phrase.downcase!
    phrase.gsub!(/[^a-zA-Z'0-9]/, ' ')
    phrase.gsub!(/\s+/, " ")
    binding.pry  
  end

end

phrase = Phrase.new('car : carpet as java : javascript!!&@$%^&')
phrase.word_count