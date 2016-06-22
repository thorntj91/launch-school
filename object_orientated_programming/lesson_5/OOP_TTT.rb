require 'pry'

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4 ,7], [2, 5 ,8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset
  end

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def [](key)
    @squares[key].marker
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

  def find_vulnerable_square(marker)
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if two_identical_markers?(squares, marker)
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

    def two_identical_markers?(squares, marker)
      markers = squares.select(&:marked?).collect(&:marker)
      return true if markers.count(marker) == 2
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
  attr_accessor :score, :name

  def initialize(marker)
    @marker = marker
    @score = 0
    @name = nil
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
    set_player_names
    display_welcome_message
    loop do # main game loop
      loop do # match loop
        display_board
        loop do # player turns
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
    board[square] = HUMAN_MARKER
  end

  def computer_moves
    square = nil
    # Offense
    square = board.find_vulnerable_square(COMPUTER_MARKER) 
    # Defense
    square = board.find_vulnerable_square(HUMAN_MARKER) if !square
    # Pick middle
    square = 5 if board[5] == Square::INITIAL_MARKER
    binding.pry
    # Else pick random
    square = board.unmarked_keys.sample if !square
    board[square] = COMPUTER_MARKER
  end

  def display_welcome_message
    clear
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_board
    puts "#{human.name} is a #{human.marker}. #{computer.name} is a #{computer.marker}"
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
    puts "#{human.name}: #{human.score}"
    puts "#{computer.name}: #{computer.score}"
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

  def set_player_names
    puts "Please enter a name: "
    human.name = gets.chomp
    computer.name = generate_computer_name
  end

  def generate_computer_name
    "#{("A".."Z").to_a.sample}#{("A".."Z").to_a.sample}-" + 
      "#{(0..9).to_a.sample}#{(0..9).to_a.sample}"
  end

end

game = TTTGame.new
game.play
