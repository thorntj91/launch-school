class Fruit
  def initialize(name)
    name = name # local variable
  end
end

class Pizza
  def initialize(name)
    @name = name # instance variable denoted by @ syntax
  end
end