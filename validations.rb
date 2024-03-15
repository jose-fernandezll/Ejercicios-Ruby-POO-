module Validations
  def must_be_positive(number, cadena)
    number = number.to_f

    until number.positive?
      puts " #{cadena} must be positive "
      number = gets.chomp.to_f
    end

    number
  end
end
