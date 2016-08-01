require 'pry'

def reduce(array, acc = 0)
  array.each { |ele| acc = yield(acc, ele) }
  acc
end

array = [1, 2, 3, 4, 5]

puts reduce(array) { |acc, num| acc + num } 
puts reduce(array, 10) { |acc, num| acc + num }
puts reduce(array) { |acc, num| acc - num }
puts reduce(array) { |acc, num| acc + num if num.odd? }