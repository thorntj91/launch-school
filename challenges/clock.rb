class Clock

  def initialize(hours, minutes)
    @current_hour = hours
    @current_minute = minutes
  end

  def self.at(hours, minutes = 0) # returns a new clock object
    new(hours, minutes)
  end

  def to_s
    format('%02d:%02d', @current_hour, @current_minute)
  end

  def +(minutes_elapsed)
    if @current_minute + (minutes_elapsed % 60) >= 60 
      @current_hour += (minutes_elapsed / 60) + 1 
    else 
      @current_hour += (minutes_elapsed / 60)
    end
    @current_minute = ((@current_minute + minutes_elapsed) % 60)
    @current_hour = @current_hour % 24

    self
  end

  def -(minutes_ago)
    if @current_minute - (minutes_ago % 60) < 0 
      @current_hour -= (minutes_ago / 60) + 1 
    else 
      @current_hour -= (minutes_ago / 60)
    end
    @current_minute = ((@current_minute - minutes_ago) % 60)
    @current_hour = @current_hour % 24

    self
  end

  def ==(object)
    object.to_s == to_s
  end
end


