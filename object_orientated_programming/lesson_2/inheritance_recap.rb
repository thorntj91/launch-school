class Mammal
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end

  def run
    'running!'
  end

  def jump
    'jumping!'
  end

end

class Dog < Mammal
  def fetch
    'fetching!'
  end
end

class Cat < Mammal
  def swim
    'Can\'t swim!'
  end

  def speak
    'Meow!'
  end
end




class Bulldog < Dog
  def swim
    'Can\'t swim!'
  end
end

rex = Bulldog.new
puts rex.swim 
puts Bulldog.ancestors