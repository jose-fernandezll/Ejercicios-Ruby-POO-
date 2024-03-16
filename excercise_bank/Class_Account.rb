require 'faker'

class Account
  attr_accessor :account

  def initialize(pin, balance)
    card_number = Faker::Number.number(digits: 10)

    @account = {
      :card_number => card_number,
      :pin => pin,
      :balance => balance
    }

  end

  def add_money(amount)
    @account[:balance] += amount
  end

  def subtract_money(amount)
    @account[:balance] -= amount
  end

  def total_balance
    @account[:balance]
  end
end

#a1 = Account.new(123, 0)
#a1.add_money(2500)
#a1.subtract_money(300)
#puts a1.total_balance
#puts a1.account
