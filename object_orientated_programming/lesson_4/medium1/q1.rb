class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end

# Ben us correct that balance is used correctly in the positive_balance? method.
# Alyssa is forgetting the fact that Ben has declared a attr_reader at the top of code
# which exposes the @balance variable through a getter method.