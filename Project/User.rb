require_relative 'modules\Roles.rb'

class User
  @@users = []
  include Roles

  def initialize(username, password, rol = 'normal')
    return puts "username  or password cant be null" if username.empty? or password.empty?

    @user = {
      :username => username,
      :password => password,
      :rol => rol
    }

    @@users.append(@user)
  end

  def self.modify_user(current_user, username, password)
    return puts "username  or password cant be null" if username.empty? or password.empty?

    @@users[current_user[:index]][:username] = username
    @@users[current_user[:index]][:password] = password

    puts "user modified"
  end

  def self.remove_user(current_user)
    @@users.delete_at(current_user[:index])
    puts "done"
  end

  def self.all_users
    #validacion rol proximamente
    @@users
  end
end


User.new('jose','121415', 'admin')
users = User.all_users

Autentication.login(users,'jose', '121415')