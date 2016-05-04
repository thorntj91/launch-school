class MyCar
  attr_accessor :color
  attr_reader :year, :model

  
  def self.mileage(miles, gallons)
    puts "#{miles / gallons}mpg"
  end

  def to_s
    puts "#{self.year} - #{self.color} - #{self.model}"
  end

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

MyCar.mileage(480, 8)

car.to_s