require_relative './Car.rb'
require_relative './Motorbike.rb'

c1 = Car.new(320, 4)
m1 = Motorbike.new(500)

puts "car 1 #{c1.turn_left}"
puts "car 1 #{c1.turn_right}"
puts "car 1 #{c1.stop}"
puts "the max speed of the car is #{c1.speed_max}"

puts "motorbike 1 #{m1.turn_left}"
puts "motorbike 1 #{m1.turn_right}"
puts "motorbike 1 #{m1.stop}"
puts "the max speed of the motorbike is #{m1.speed_max}"


