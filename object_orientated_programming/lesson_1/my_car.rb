class MyCar
  attr_accessor :color
  attr_reader :year

  def initialize(year, color, model)
    @speed = 0

    @year = year
    @color = color
    @model = model
  end

  def speed_up
    @speed += 20
  end

  def brake
    @speed -= 10
  end

  def shut_off
    @speed = 0
  end

  def spray_paint(color)
    self.color = color
  end

end

car = MyCar.new(2009, "black", "Mini Cooper D")

p car

car.speed_up
p car
car.brake
p car
car.shut_off
p car

puts car.year
car.color = "Black and White"
puts car.color

car.spray_paint("Neon Pink")
puts car.color