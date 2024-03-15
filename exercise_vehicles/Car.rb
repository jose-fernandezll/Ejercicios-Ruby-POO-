require_relative './Vehicle.rb'
class Car < Vehicle
  def initialize(max_speed, number_of_seats)
    super(max_speed)
    @number_of_seats = number_of_seats
  end
end
