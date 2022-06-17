# Template Method Pattern
# Date: 03-Mar-2022
# Authors:
#          A01377744 Alejandro Torices Oliva
#          A01376544 Mariana Paola Caballero Cabrera
# File name: student.rb

# A class that models a student with an id, a name and a number of grades
class Student

  include Enumerable
  # Note: This class does not support the max, min,
  # or sort methods.

  def initialize(id, name, grades)
    @id = id
    @name = name
    @grades = grades
  end

  # Method that returns the Student() with it's id and name
  def inspect
    "Student(#{@id}, #{@name.inspect})"
  end

  # This method computes the average grade of each student
  def grade_average
    @grades.inject(:+)/@grades.size
  end

  # A proc, that returns a student id, name, each one of it's grades, and the average grade.
  def each &block
    yield @id
    yield @name
    @grades.each(&block)
    yield grade_average
  end

end