require_relative './validations.rb'

class Person
  attr_accessor :name, :age
  include Validations


  def initialize(name, age)
    @age = must_be_positive(age, 'age')
    @name = name
  end

  def introduction
    puts "hola soy #{@name}"
  end
end

#p1 = Person.new('paco', 32)
#p2 = Person.new('mario',64)
#
#puts "su nombre es: #{p1.name} y su edad es #{p1.age}"
#puts "su nombre es: #{p2.name} y su edad es #{p2.age}"
