class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end

# To instantiate a new instance of bag you call the new method which will
# call Bag's constructor. Two arguments must also be provided in this case.

bag = Bag.new("red", "leather")
