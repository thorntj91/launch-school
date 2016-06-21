require 'pry'

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4 ,7], [2, 5 ,8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset
  end

  def get_square_at(key)
    @squares[key]
  end

  def set_square_at(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def vulnerable_square?
    !!vulnerable_square
  end

  # returns winning marker or nil
  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def vulnerable_square
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if two_player_markers?(squares)
        line.each do |index|
          return index if @squares[index].marker == " "
        end
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}  "
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}  "
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}  "
    puts "     |     |"
  end
  
  private
  
    def three_identical_markers?(squares)
      markers = squares.select(&:marked?).collect(&:marker)
      return false if markers.size != 3
      markers.min == markers.max
    end

    def two_player_markers?(squares)
      markers = squares.select(&:marked?).collect(&:marker)
      return true if markers.count("X") == 2
      false
    end


end


class Square
  INITIAL_MARKER = " "
  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    !unmarked?
  end

end

class Player
  attr_reader :marker
  attr_accessor :score

  def initialize(marker)
    @marker = marker
    @score = 0
  end
end

class TTTGame
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"
  FIRST_TO_MOVE = HUMAN_MARKER
  attr_reader :board, :human, :computer
  attr_accessor :current_player

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_player = FIRST_TO_MOVE
  end

  def play
    display_welcome_message
    loop do
      loop do
        display_board
        loop do
          current_player_moves
          break if board.someone_won? || board.full?
          clear_screen_and_display_board if human_turn?
        end
        if !board.winning_marker.nil?
          board.winning_marker == HUMAN_MARKER ? human.score += 1 : computer.score += 1
        end
        display_result
        break if game_over?
        puts "Press enter to continue"
        gets.chomp
        reset_match
      end
      break unless play_again?
      display_play_again_message
      reset
    end
    display_goodbye_message
  end

  private

  def game_over?
    human.score == 5 || computer.score == 5
  end

  def clear
    system 'clear'
  end

  def human_turn?
    current_player == HUMAN_MARKER
  end

  def current_player_moves
    if human_turn? 
      human_moves
      @current_player = COMPUTER_MARKER
    else
      computer_moves
      @current_player = HUMAN_MARKER
    end
  end

  def human_moves
    puts "Choose a square (#{board.unmarked_keys.join(', ')})"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    board.set_square_at(square, human.marker)
  end

  def computer_moves
    if board.vulnerable_square?
      board.set_square_at(board.vulnerable_square, computer.marker)
    else
      board.set_square_at(board.unmarked_keys.sample, computer.marker)
    end
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_board
    puts "You're a #{human.marker}. Computer is a #{computer.marker}"
    puts ""
    board.draw
    display_score
    puts ""
  end

  def clear_screen_and_display_board
    clear
    display_board
  end


  def display_result
    display_board
    case board.winning_marker
    when human.marker
      puts "You won!"
    when computer.marker
      puts "Computer won!"
    else
      puts "It's a tie"
    end
  end

  def display_score
    puts ""
    puts "You: #{human.score}"
    puts "Computer: #{computer.score}"
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again?"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n"
    end
    answer == 'y'
  end

  def reset_match
    board.reset
    @current_player = FIRST_TO_MOVE
    clear
  end

  def reset
    human.score = 0
    computer.score = 0
    reset_match
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end

end

game = TTTGame.new
game.play
