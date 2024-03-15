class Rectangle
  def initialize(length ,width)
    @length = length
    @width = width
  end

  def area
    @width * @length
  end

  def perimeter
    @length * 2 + @width * 2
  end
end

r1 = Rectangle.new(10, 5)

r2 = Rectangle.new(2, 3)


puts "el perimetro es: #{r1.perimeter} y el area es: #{r1.area}"

puts "el perimetro es: #{r2.perimeter} y el area es: #{r2.area}"

