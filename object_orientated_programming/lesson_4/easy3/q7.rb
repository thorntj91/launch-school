class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    return "I want to turn on the light with a brightness level of super high and a colour of green"
  end

end

# The class method information serves no purpose.
# It describes the usage of a specific instance of a Light object,
# not something broadly applicable to the class as a whole.