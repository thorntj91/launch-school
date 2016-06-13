class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

# If we decided to add a play method to the Bingo explicitly
# since Bingo implements its own play method, this will override the 
# play method of the super class and Bingo's implementation will be used.
# Ruby achieves this by first looking in current class for the method before
# consulting further up the chain.