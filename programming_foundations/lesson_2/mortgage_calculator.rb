MONTHS_IN_YEAR = 12

def mortage_payment(annual_rate, duration, amount)
  dur_in_months = duration * MONTHS_IN_YEAR
  monthly_rate = (annual_rate / MONTHS_IN_YEAR) / 100

  amount * ( monthly_rate / ( 1 - (1 + monthly_rate)**-dur_in_months))
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

def positive?(num)
  num.to_f > 0
end

def prompt(message)
  puts "=> #{message}"
end

def prompt_input(message)
  loop do
    prompt(message)
    input = gets.chomp

    return input if number?(input) && positive?(input)

    prompt('Number is invalid, please try again')
  end
end

prompt 'Welcome to the mortgage calculator'
prompt 'We will need a few figures to get started'

amount = prompt_input('Please enter the loan amount')
duration = prompt_input('How many years do you intend on paying it back over?')
annual_rate = prompt_input('Now enter the interest rate (APR):')

monthly_payment = mortage_payment(annual_rate.to_f, duration.to_f, amount.to_f)

printf("Your monthly mortage payments will be: %0.2f\n", monthly_payment)
