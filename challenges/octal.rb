require 'pry'

class Octal

  def initialize(number)
    @octal = number.split("")
  end


  def to_decimal
    return 0 unless is_octal?(@octal)

    @octal.map!(&:to_i)

    decimal = @octal.reverse.each_with_index.reduce(0) do |sum, (value, index)|
      sum += (8**index) * value
    end
  end

  private

  def is_octal?(number)
    number.each do |digit| 
      return false unless ['0','1','2','3','4','5','6','7'].include?(digit) 
    end
    true
  end

end
