VALID_CHOICES = { r: 'rock', p: 'paper', s: 'scissors', l: 'lizard',
  sp: 'spock' }.freeze

score = 0 

def prompt(message)
  puts "=> #{message}"
end

def win?(first, second)
  (first == 'rock') && (second == 'scissors' || second == 'lizard') ||
    (first == 'paper') && (second == 'rock' || second == 'spock') ||
    (first == 'scissors') && (second == 'paper' || second == 'lizard') ||
    (first == 'spock') && (second == 'scissors' || second == 'rock') ||
    (first == 'lizard') && (second == 'spock' || second == 'paper')
end

def update_score(player, computer, score)
  score += 1 if win?(player, computer)
  
  if win?(computer, player)
    score -= 1 unless score == 0
  end
  score
end

def display_results(player, computer)
  if win?(player, computer)
    prompt("You won!")
  elsif win?(computer, player)
    prompt("Computer won!")
  else
    prompt("It's a tie")
  end
end

loop do
  choice = ''
  loop do
    prompt('Choose one of the following: ')
    choices = VALID_CHOICES.map{|key, value| "#{value} (#{key})"}.join(', ')
    prompt(choices)
    choice = gets.chomp

    if VALID_CHOICES.has_key?(choice.to_sym)
      choice = VALID_CHOICES[choice.to_sym]
      break
    elsif VALID_CHOICES.has_value?(choice)
      break
    else
      prompt("That's not a valid choice.")
    end
  end

  computer_choice = VALID_CHOICES.values.sample

  prompt("Your choice was: #{choice}; The computer chose: #{computer_choice}")

  score = update_score(choice, computer_choice, score)

  display_results(choice, computer_choice)

  prompt("Current score: #{score}")
  prompt("Do you want to play again?")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt("Thank you for playing. Good bye!")
