require_relative './Class_Account.rb'

class Client
  attr_accessor :accounts, :name

  def initialize(name, email)
    @name = name
    @email = email
    @accounts = []
  end

  def add_account(pin, balance)
    @accounts.append(Account.new(pin,balance))
  end

  def remove_account(number)
    for object in @accounts
      @accounts.delete(object) if object.account[:card_number] == number
    end
  end
end

#c1 = Client.new('jose', 'josefernandezllanos03@gmail.com')
#c1.add_account(1234,0000)
#
#puts c1.accounts
#puts c1.accounts[0].account
#
#c1.remove_account(c1.accounts[0].account[:card_number])
#puts "se imprime #{c1.accounts}"  unless c1.accounts.length == 0
