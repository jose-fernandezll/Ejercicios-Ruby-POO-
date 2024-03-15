require_relative './module/habilidades.rb'
class Vehicle
  include Skills
  def initialize(speed_max)
    @speed_max = speed_max
  end

  def speed_max
    @speed_max
  end
end

v1 = Vehicle.new(245)
v1.turn_right
