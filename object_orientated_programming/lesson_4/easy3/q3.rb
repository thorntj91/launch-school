class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

churlish_cheshire = AngryCat.new(2, "Chester")
surly_siamese = AngryCat.new(5, "Sylvester")