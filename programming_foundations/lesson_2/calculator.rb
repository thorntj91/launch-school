def perform_op(operator, operands)
  case operator
  when '*'
    puts operands[0] * operands[1]
  when '/'
    puts operands[0].to_f / operands[1].to_f
  when '-'
    puts operands[0] - operands[1]
  when '+'
    puts operands[0] + operands[1]
  end
end

operands = []

puts 'Please enter first number'
operands << gets.chomp.to_i
puts 'Now, please enter the second number'
operands << gets.chomp.to_i
puts 'Now, please enter an operation to perform on these numbers'
operator = gets.chomp

perform_op(operator, operands)
