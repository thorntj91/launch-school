class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

tv = Television.new
tv.manufacturer # No method found since this calls the self.manufacturer, not manufacturer
tv.model # Returns the result of the model method

Television.manufacturer # Returns the result of the self.manufacturer method
Television.model # No method found since there is no self.model class method. Just a model instant method