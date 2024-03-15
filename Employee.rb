require_relative './Person.rb'

class Employee < Person
  attr_accessor :salary

  def initialize(name, age, salary)
    super(name, age)
    @salary = salary
  end

  def introduction
    puts "hola soy el empleado #{@name} y mi salario es #{@salary}"
  end
end

e1 = Employee.new('jose', 20, 35000)
p1 = Person.new('paco', 45)

puts "your name is #{e1.name} and your age is: #{e1.age} and your current salary is: #{e1.salary}"


e1.introduction
p1.introduction
