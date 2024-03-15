require_relative './Person.rb'
require_relative './validations.rb'

class Employee < Person
  attr_accessor :salary
  include Validations

  def initialize(name, age, salary)
    age = must_be_positive(age, 'age')
    super(name, age)

    @salary = must_be_positive(salary, 'salary')
  end

  def introduction
    puts "hola soy el empleado #{@name} y mi salario es #{@salary}"
  end
end

e1 = Employee.new('jose', -20, -255)
p1 = Person.new('paco', 45)

puts "your name is #{e1.name} and your age is: #{e1.age} and your current salary is: #{e1.salary}"


e1.introduction
p1.introduction
