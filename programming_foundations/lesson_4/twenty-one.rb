require 'pry'
RANKS = {
  Ace: {low: 1, high: 11}, two: 2, three: 3, four: 4, five: 5, six: 6, seven: 7, eight: 8,
  nine: 9, ten: 10, Jack: 10, Queen: 10, King: 10
}.freeze

def prompt(message)
  puts "=> #{message}"
end

def deal(deck)
  hand = []
  2.times do
    suit = deck.keys.sample(1)
    rank = RANKS.keys.sample(1)
    hand << rank.product(suit).flatten
    deck[suit.pop].delete(rank.pop)
  end
  hand
end

def draw(deck)
  suit = deck.keys.sample(1)
  rank = RANKS.keys.sample(1)
  card = rank.product(suit).flatten
  deck[suit.pop].delete(rank.pop)
  card
end

def hit_or_stay?
  prompt("Do you want to hit or stay?")
  response = gets.chomp
  if response == "hit"
    true
  else
    false
  end
end

def aces_present(cards)
  count = 0
  cards.each { |card| count += 1 if card[0] == :Ace }
  count
end

def value(cards)
  total = 0
  # Count total of all non-aces and mark aces
  cards.each do |card|
    next if card[0] == :Ace
    total += RANKS[card[0]]
  end
  count = aces_present(cards)
  # Add aces while
  while count > 0
    if total <= 10
      total += 1
    else
      total += 11
    end
    count -= 1
  end

  total
end

def busted?(cards)
  value(cards) > 21 ? true : false
end

def show(dealer_cards, player_cards)
  cards = ""
  dealer_cards.each do |card|
    next if card == dealer_cards.first
    cards << card[0].to_s + " of " + card[1].to_s + ", "
  end
  prompt "Dealer has: " + cards + "and unknown card"

  cards = ""
  if player_cards.length == 2
    prompt "You have: " +
    player_cards[0][0].to_s + " of " + player_cards[0][1].to_s + " and " +
    player_cards[1][0].to_s + " of " + player_cards[1][1].to_s
  else
    player_cards.each do |card|
      cards << card[0].to_s + " of " + card[1].to_s + ", "
    end
    prompt "You have: " + cards
  end
end

loop do
  deck = {
    hearts: RANKS.clone, spades: RANKS.clone,
    diamonds: RANKS.clone, clubs: RANKS.clone
  }

  players_hand = deal(deck)
  dealers_hand = deal(deck)

  loop do # game loop
    system 'clear'
    show dealers_hand, players_hand
    loop do # players turn
      hit = hit_or_stay?
      break if hit == false
      card = draw(deck)
      prompt("You drew: " + card[0].to_s + " of " + card[1].to_s)
      players_hand << card
      break if busted?(players_hand)
    end

    if busted?(players_hand)
      prompt("Bust!")
      break
    end

    while value(dealers_hand) < 17
      break if busted?(dealers_hand)
      prompt("(The dealer draws)")
      dealers_hand << draw(deck)
    end

    if busted?(dealers_hand)
      system 'clear'
      show dealers_hand, players_hand
      prompt("Dealer has bust! You win!")
      prompt("You: #{value(players_hand)}")
      prompt("Dealer: #{value(dealers_hand)}")
      break
    else
      prompt("(The dealer stays)")
      show dealers_hand, players_hand
    end
  end
  prompt("Would you like to play again?")

  user_input = gets.chomp.downcase
  break if user_input == "n" || user_input == "no"
end
prompt("Thanks for playing! Goodbye!")
