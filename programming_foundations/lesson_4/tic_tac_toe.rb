def display(board)
  board.each do |row| 
    row.each_with_index do |cell, index| 
      if index == ( row.length - 1 ) 
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
    row.each_with_index do |cell, index| 
      if cell != '| |'
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
  # Random value in range 0-2
  x_val = (rand * ((2 - 0) + 1 )).floor
  y_val = (rand * ((3 - 1) + 1 )).floor
  { x: x_val, y: y_val }
end

def vertical(board)
  (0..2).each do |y|
    if ( board[0][y] == board[1][y] && board[1][y] == board[2][y] ) &&
       board[0][y] != '| |' 
      prompt("#{board[0][y]} us the winner!")
      return true
    end
  end
  false
end

def horizontal(board)
  (0..2).each do |x| 
    if ( board[x][0] == board[x][1] && board[x][1] == board[x][2] ) &&
       board[x][0] != '| |' 
      prompt("#{board[x][0]} is the winner!")
      return true
    end
  end
  false
end

def diagonal(board)
  if board[1][1] != '| |'
    if ( board[0][0] == board[1][1] && board[1][1] == board[2][2] ) ||
      ( board[0][2] == board[1][1] && board[1][1] == board[2][0] )
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
  board = Array.new(3, '| |') { Array.new(3, '| |') }
  loop do 
    input = {}

    display board
    
    prompt("To choose a square, enter the row number (e.g. 1,2,3)")
    input[:x] = gets.chomp.to_i - 1
    prompt("Great. Now choose a column (e.g. 1,2,3)")
    input[:y] = gets.chomp.to_i - 1 

    board[input[:x]][input[:y]] = '|O|'

    cpu = {}
    loop do 
      cpu = computer_move
      break if board[cpu[:x]][cpu[:y]] == '| |'
    end

    board[cpu[:x]][cpu[:y]] = '|X|'

    display board
    puts ' '

    prompt("Tie!") if full?(board)
    break if win?(board)

  end
  prompt("Would you like to play again?")

  user_input = gets.chomp.downcase
  break if user_input == "n" || user_input == "no"
end

prompt("Thanks for playing! Goodbye!")