require 'pry'

BOARD_MAP = {
  1 => [0, 0], 2 => [0, 1], 3 => [0, 2],
  4 => [1, 0], 5 => [1, 1], 6 => [1, 2],
  7 => [2, 0], 8 => [2, 1], 9 => [2, 2]
}.freeze
INITIAL_MARKER = '| |'.freeze
PLAYER_MARKER = '|O|'.freeze
COMPUTER_MARKER = '|X|'.freeze

def display(board)
  system 'clear'
  board.each do |row|
    row.each_with_index do |cell, index|
      if index == (row.length - 1)
        puts cell
      else
        print cell
      end
    end
  end
end

def full?(board)
  count = 0
  board.each do |row|
    row.each do |cell|
      if cell != INITIAL_MARKER
        count += 1
      end
    end
  end
  return true if count == 9
  false
end

def prompt(message)
  puts "=> #{message}"
end

def computer_move
  # Random value in range 1-9
  val = (rand * ((9 - 1) + 1) + 1).floor
  BOARD_MAP[val]
end

def computer_places_piece!(board)
  choice = []
  loop do
    choice = computer_move
    break if board[choice.first][choice.last] == INITIAL_MARKER
  end
  board[choice.first][choice.last] = COMPUTER_MARKER
end

def player_places_piece!(board)
  prompt("Choose a square 1-9")

  choice = BOARD_MAP[gets.chomp.to_i]
  board[choice.first][choice.last] = PLAYER_MARKER
end

def vertical(board)
  (0..2).each do |y|
    if (board[0][y] == board[1][y] && board[1][y] == board[2][y]) &&
       board[0][y] != INITIAL_MARKER
      display board
      prompt("#{board[0][y]} us the winner!")
      return true
    end
  end
  false
end

def horizontal(board)
  (0..2).each do |x|
    if (board[x][0] == board[x][1] && board[x][1] == board[x][2]) &&
       board[x][0] != INITIAL_MARKER
      display board
      prompt("#{board[x][0]} is the winner!")
      return true
    end
  end
  false
end

def diagonal(board)
  if board[1][1] != INITIAL_MARKER
    if (board[0][0] == board[1][1] && board[1][1] == board[2][2]) ||
       (board[0][2] == board[1][1] && board[1][1] == board[2][0])
      display board
      prompt("#{board[1][1]} is the winner!")
      return true
    end
  end
  false
end

def win?(board)
  return true if diagonal(board) || horizontal(board) || vertical(board)
end

loop do
  board = Array.new(3, INITIAL_MARKER) { Array.new(3, INITIAL_MARKER) }
  loop do
    display board

    player_places_piece!(board)

    computer_places_piece!(board)

    prompt("Tie!") if full?(board)
    break if win?(board)
  end
  prompt("Would you like to play again?")

  user_input = gets.chomp.downcase
  break if user_input == "n" || user_input == "no"
end
prompt("Thanks for playing! Goodbye!")
