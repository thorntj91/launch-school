class KrispyKreme
  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
  end

  def to_s
    if @filling_type.nil? && @glazing.nil?
      "Plain"
    elsif @filling_type.nil?
      "Plain with #{@glazing}"
    elsif @glazing.nil?
      "#{@filling_type}"
    else
      "#{@filling_type} with #{@glazing}"
    end
  end
end



