require 'pry'

module Haulable
  def load_cargo(cargo)
    @cargo = cargo
    puts "#{@cargo} - Loaded"
  end
end


class Vehicle
  attr_accessor :color
  attr_reader :year, :model

  @@number_of_vehicles = 0

  def initialize(year, color, model)
    @@number_of_vehicles += 1
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def self.number_of_vehicles
    puts @@number_of_vehicles
  end

  def self.mileage(miles, gallons)
    puts "#{miles / gallons}mpg"
  end

  def speed_up
    @speed += 20
  end

  def current_speed
    puts @speed
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
  
  def to_s
    puts "#{self.year} - #{self.color} - #{self.model}"
    puts "Age: #{age} years old"
  end

  private

  def age
    @age = Time.now.year - self.year
  end


end

class MyTruck < Vehicle
  include Haulable
  NUMBER_OF_DOORS = 2
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
end

car = MyCar.new(2009, "black", "Mini Cooper D")

p car

car.speed_up
puts car.current_speed
car.brake
puts car.current_speed
car.shut_off
puts car.current_speed

puts car.year
car.color = "Black and White"
puts car.color

car.spray_paint("Neon Pink")
puts car.color

MyCar.mileage(480, 8)

car.to_s

other_car = MyCar.new(2014, "red", "Kia Pro Ceed")
puts other_car.to_s

puts "Creating truck..."
truck = MyTruck.new(2012, "grey", "Ford F-150")

puts "There are now #{Vehicle.number_of_vehicles} vehicles"

truck.load_cargo("consignment of bricks")

puts Vehicle.ancestors
puts "------------"
puts MyCar.ancestors
puts "------------"
puts MyTruck.ancestors
