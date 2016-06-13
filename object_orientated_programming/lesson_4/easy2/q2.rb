class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

trip = RoadTrip.new
trip.predict_the_future # => "You will " <visit Vegas..etc> 

# Prints the road trip choices since first the trip object looks to it's super class
# when it cannot find the predict_the_future method in RoadTrip.
# This method calls choices, which since it's being called from an instance of RoadTrip
# It will check to see if there's a definition of choices in that class first.
