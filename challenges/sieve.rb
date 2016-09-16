class Sieve

	attr_accessor :range

	def initialize(num)
		@range = (2..num).to_a
  end

  def primes
    remove_multiples(2, range)
	end

  def remove_multiples(number, array)

    return array if (2 * number) > range.last
    range = array

    number += 1 unless array.include?(number)
    
    range.reject! { |i| i % number == 0  && i != number}

    remove_multiples(number + 1, range)
  end

end