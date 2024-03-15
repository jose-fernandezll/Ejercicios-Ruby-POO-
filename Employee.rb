require_relative './Person.rb'

class Employee < Person
  attr_accessor :salary
  def initialize(name, age, salary)
    super(name, age)
    @salary = salary
  end
end

e1 = Employee.new('jose', 20, 35000)

puts "your name is #{e1.name} and your age is: #{e1.age} and your current salary is: #{e1.salary}"
