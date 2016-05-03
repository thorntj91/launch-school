def reverse_it(array)
  reversed_array = []
  array.length.times do |ele|
    reversed_array << array.pop
  end
  reversed_array
end

def is_palindrome?(string)
  reversed_string = reverse_it(string.split("")).join("")
  
  return true if string.downcase == reversed_string.downcase
  false
end

p is_palindrome?("jake")
p is_palindrome?("mum")
p is_palindrome?("Hannah")


