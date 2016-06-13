class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game # Inherits from Game
  def rules_of_play
    #rules of play
  end
end

# Valid:
# bingo_game = Bingo.new
# bingo_game.play