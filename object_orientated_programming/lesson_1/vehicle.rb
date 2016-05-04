module Radio
  def tune_into(channel)
    puts "#{channel} Now Playing"
  end
end

class Vehicle
  include Radio
  attr_accessor :name, :colour
end

car = Vehicle.new
car.name = "Mini Cooper"
car.colour = "Black"

p car
car.tune_into("Planet Rock")
