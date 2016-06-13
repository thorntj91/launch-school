class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    quantity = updated_count if updated_count >= 0
  end
end

# If we change the add a attr_accessor, we will solve the issue with update_quantity
# However we must be careful not to add any functionality which we don't intend.
# Referencing the variable directly by prefixing at would also solve this problem however,
# We do expose the variable externally via a setter method as would be the case with
# an attr_accessor.