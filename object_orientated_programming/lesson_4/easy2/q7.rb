class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

# cats_count variable is a class variable which means one instance of it exists
# for all Cat objects.
# The self.cats_count class method is called each time a Cat object is instantiated
# The effect of this will be that we will count the number of cats by 
# incrementing cat count each time a new Cat is made.