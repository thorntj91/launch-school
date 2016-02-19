def prompt(message)
  Kernel.puts("=> #{message}")
end

def integer?(num)
  /^\d+$/.match(num)
end

def float?(num)
  num.to_f.to_s == num
end

def number?(num)
  float?(num) || integer?(num)
end

operand1 = ""
operand2 = ""
operator = ""

loop do
  prompt("Welcome to Calculator")

  loop do
    prompt("Please enter first number")
    operand1 = gets.chomp

    break if number?(operand1)

    prompt("Doesn't seem like a valid number")
  end

  loop do
    prompt("Now, please enter the second number")
    operand2 = gets.chomp

    break if number?(operand2)

    prompt("Doesn't seem like a valid number")
  end

  loop do
    prompt("Now, please enter an operation to perform on these numbers")
    operator = gets.chomp

    break if %w(+ - / *).include? operator

    prompt("Invalid operator. Try: +, -, *, /")
  end

  result =
    case operator
    when '*'
      operand1.to_i * operand2.to_i
    when '/'
      operand1.to_f / operand2.to_f
    when '-'
      operand1.to_i - operand2.to_i
    when '+'
      operand1.to_i + operand2.to_i
    end

  prompt("This is the result: #{result}")

  prompt("Do you want to calculate again?")

  break unless gets.chomp.include?("y")
end # main loop
