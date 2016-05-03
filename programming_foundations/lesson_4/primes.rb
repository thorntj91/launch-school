require 'pry'

def find_primes(first, last)
  (first..last).select do |n|
    is_prime?(n)
  end
end

def is_prime?(number)
  (2..(number - 1)).each do |divisor|
    break if number % divisor == 0
    return true
  end
  false
end


p find_primes(3, 10)