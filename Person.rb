class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
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
