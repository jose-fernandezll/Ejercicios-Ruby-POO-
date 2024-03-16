require_relative './Class_Client.rb'

class Bank
  @@clients = []
  def self.add_client(name,email)
    client = Client.new(name, email)
    @@clients.append(client)
  end

  def self.search_client(name)
    for object in @@clients
      return object if object.name.eql?(name)
    end
  end
end

Bank.add_client('jose','josefernandezllanos03@gmail.com')
c1 = Bank.search_client('jose')
c1.add_account(1234,25000)
puts "#{c1.accounts}"
