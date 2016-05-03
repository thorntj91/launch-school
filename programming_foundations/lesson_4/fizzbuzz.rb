require 'pry'

def fizzbuzz(first, last)
  fizzbuzzed_range = []
  (first..last).each do |n|
    x1 = n % 3 == 0
    x2 = n % 5 == 0

    fizzbuzzed = case
      when (x1 and x2) then "fizzbuzz"
      when x1 then "fizz"
      when x2 then "buzz"
      else n
    end
    fizzbuzzed_range << fizzbuzzed
  end
  puts "#{fizzbuzzed_range.join(", ")}"
end

fizzbuzz(1,15)

#If divisible by 3 print fizz
#If divisible by 5 print buzz
#If divisible by 3 and 5 print fizzbuzz