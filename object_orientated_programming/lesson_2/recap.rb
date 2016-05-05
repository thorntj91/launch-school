class Person
  attr_accessor :first_name, :last_name
  attr_reader :name

  def initialize(name)
    parts = name.split
    @first_name = parts.first
    @last_name = parts.size > 1 ? parts.last : ''
  end

  def name=(name)
    split_name = name.split(" ")
    self.first_name = split_name.first
    self.last_name = split_name.last
  end

end

bob = Person.new('Robert')
bob.name             
puts bob.first_name 
puts bob.last_name
bob.last_name = 'Smith'
bob.name 

bob.name = "Jake Thornton"
puts bob.first_name
puts bob.last_name

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

puts bob.name.equal?(rob.name)