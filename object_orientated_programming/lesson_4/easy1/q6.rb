class Cube
  # Provides read/write access to the volume instance variable via 
  # a set of accessor/mutator methods
  attr_accessor :volume
  def initialize(volume)
    @volume = volume
  end
end

cube = Cube.new(300)

cube.volume # => 300