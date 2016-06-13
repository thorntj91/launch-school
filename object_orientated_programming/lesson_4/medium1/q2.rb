class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    quantity = updated_count if updated_count >= 0
  end
end

# update_quantity will fail since the @quanity variable which is being updated,
# is not exposed for writing via a setter method.
# An attr_accessor or attr_writer would need to be declared in order to provide
# write access to that variable