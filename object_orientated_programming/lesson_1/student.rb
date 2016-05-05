require 'pry'

class Student
  attr_accessor :name

  def initialize(name, grade)
    self.name = name
    @grade = grade
  end

  def better_grade_than?(student)
    return true if grade > student.grade
    false
  end 

  protected

  def grade
    @grade
  end

end

jack = Student.new("Jack", 81)
jill = Student.new("Jill", 60)


if jack.better_grade_than?(jill)
  puts "Well done #{jack.name}"
else
  puts "Well done #{jill.name}"
end 