class Luhn

  def initialize(number)
    @digits = number.to_s.split('').map(&:to_i)
  end

  def addends
    odds = @digits.reverse.map.with_index do |digit, index|
      if index % 2 != 0
        digit * 2 >= 10 ? (digit * 2) - 9 : digit * 2 
      else
        digit
      end
    end
    odds.reverse
  end

  def checksum
    sum = addends.reduce(&:+)
  end

  def valid?
    checksum % 10 == 0
  end

  def self.create(partial_number)
    if new(partial_number * 10).valid?
      partial_number * 10
    else
      check_digit = new(partial_number * 10).checksum % 10 
      (10 - check_digit) + partial_number * 10
    end
  end

end
