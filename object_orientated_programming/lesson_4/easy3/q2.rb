class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# We can call Hello.hi if we modify the class as such:
class Hello < Greeting
  def self.hi
    greet("Hello")
  end
end

# This promotes hi to a class level method.