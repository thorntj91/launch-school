
string = "hello"

def reverse(string)
  split_string = string.split("")
  reversed_string = []
  split_string.reverse_each do |letter|
    #push it onto new array
    reversed_string += [letter]
  end
  reversed_string.join("")
end

p reverse(string)