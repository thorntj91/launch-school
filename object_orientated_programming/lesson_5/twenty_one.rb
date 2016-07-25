# Provides functionality to manage a hand of cards
module Hand
  def show_hand
    puts "#{name}'s cards are:"
    cards.each { |card| puts card }
  end

  def total
    total = 0
    cards.each do |card|
        total += card.value
    end

    cards.select { |card| card.rank == 'Ace' }.count.times do
      total -= 10 if total > 21
    end
    total
  end

  def add_card(card)
    cards << card
  end

  def busted?
    total < 22 ? false : true
  end

  def discard_hand
    self.cards = []
  end
end

# A generic player in a game
class Participant
  include Hand

  attr_accessor :cards, :name
  def initialize
    @cards = []
    set_name
  end
end

# Human controlled player of the game
class Player < Participant
  def set_name
    name = nil
    loop do
      puts 'Please enter your name: '
      name = gets.chomp
      system 'clear'
      puts "\"#{name}\""
      puts 'Is this correct? (y/n)'
      answer = gets.chomp
      break unless answer == 'n'
    end
    self.name = name
    system 'clear'
  end
end

# AI card dealer opponent
class Dealer < Participant
  def set_name
    self.name = "#{[*'A'..'Z'].sample}#{[*'A'..'Z'].sample}-" \
                "#{[*0..9].sample}#{[*0..9].sample}"
  end

  def show_hand
    puts "Dealer #{name}'s cards are:"
    cards.each_with_index do |card, index|
      next if index == 0
      puts card
    end
    puts 'and Unknown card'
  end
end

# Data structure to represent standard deck of playing cards
class Deck
  RANKS = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace'].freeze
  SUITS = %w(clubs diamonds hearts spades).freeze
  attr_accessor :cards

  def initialize
    @cards = []
    SUITS.each { |suit| RANKS.each { |rank| @cards << Card.new(suit, rank) } }
  end

  def shuffle!
    cards.shuffle!
  end

  def [](index)
    cards[index]
  end

  def draw
    cards.pop
  end
end

# Standard playing card with suit and rank
class Card
  attr_reader :suit, :rank, :value

  def initialize(suit, rank)
    @suit = suit
    @rank = rank
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def value
    return @rank if [*2..9].include?(@rank)
    return 11 if @rank == 'Ace'
    10
  end
end

# Game facilitator
class Game
  attr_accessor :player, :dealer, :deck

  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @deck = Deck.new
    @deck.shuffle!
  end

  def reset
    player.discard_hand
    dealer.discard_hand
    deck = Deck.new
    deck.shuffle!
  end

  def detect_winner
    case
    when player.busted?
      puts "#{player.name} bust!"
      return dealer
    when dealer.busted?
      puts "#{dealer.name} bust!"
      return player
    when player.total == dealer.total
      puts 'It\'s a tie!'
    else
      return player.total > dealer.total ? player : dealer
    end
  end

  def display_totals
    puts 'Totals:'
    puts "#{player.name}: #{player.total}"
    puts "#{dealer.name}: #{dealer.total}"
  end

  def display_winner
    system 'clear'
    if winner = detect_winner
      puts "#{winner.name} wins!"
    end
    puts ''
    show_cards
    puts ''
    display_totals
  end

  def show_cards
    player.show_hand
    puts ''
    dealer.show_hand
  end

  def deal_cards
    2.times do
      player.add_card(deck.draw)
      dealer.add_card(deck.draw)
    end
  end

  def deal_card(participant)
    participant.add_card(deck.draw)
  end

  def hit_or_stay
    answer = nil
    loop do
      answer = gets.chomp.downcase
      break if answer == 'hit' || answer == 'stay'
      puts 'Sorry, that\'s an invalid response'
    end
    answer
  end

  def player_turn
    loop do
      puts 'Do you want to hit or stay?'
      answer = hit_or_stay
      break if answer == 'stay'
      deal_card(player)
      break if player.busted?
      system 'clear'
      show_cards
    end
  end

  def dealer_turn
    deal_card(dealer) while dealer.total < 17
  end

  def play
    deal_cards # deals x cards from the deck to a specific player
    show_cards # for each participant show each hand
    player_turn
    return if player.busted?
    dealer_turn
    return if dealer.busted?
  end
end

game = Game.new
loop do
  game.play
  game.display_winner
  puts 'Would you like to play again? (y/n)'
  answer = gets.chomp.downcase
  break unless answer == 'y'
  game.reset
  system 'clear'
end
puts 'Thank you for playing. Goodbye!'
