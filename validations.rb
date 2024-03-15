module Validations
  def must_be_positive(number, cadena)
    begin
      raise " #{cadena} must be positive" if number.to_f.negative?

      number
    rescue Exception => error
      while number.negative?
        puts error.message
        number = gets.chomp.to_f
        number.is_a?(Float)
      end
      number
    end
  end
end
