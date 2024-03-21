require_relative 'modules\Autentication.rb'

class User
  @@users = []
  include Autentication
  include Roles

  def initialize(username, password, rol = 'normal')
    return puts "username  or password cant be null" if username.empty? or password.empty?

    @user = {
      :username => username,
      :password => password,
      :rol => rol
    }

    @@users.append(@user)

    'created user'
  end

  def self.modify_user( new_username, new_password, old_password)
    return puts 'you need to be loged' unless Autentication.is_loged?
    return 'Incorrect password' if current_user[:password] != old_password
    current_user = Autentication.current_user
    return puts "username  or password cant be null" if new_username.empty? or new_password.empty?
    @@users[current_user[:index]][:username] = username
    @@users[current_user[:index]][:password] = password

    "user modified"
  end

  def self.remove_user
    return puts 'you need to be loged' unless Autentication.is_loged?
    current_user = Autentication.current_user

    @@users.delete_at(current_user[:index])
    "done"
  end

  def self.remove_user_admin(username)
    user = {}
    @@users.each_with_index do |user, index|
      if user[:username] == username
        user[:index] = index
      end
    end

    @@users.delete_at(user[:index])
    "done"
  end

  def self.all_users
    @@users
  end
end


#User.new('jose','121415', 'admin')
#users = User.all_users
#
#Autentication.login(users,'jose', '121415')
#User.modify_user('jose-ismael','121415')
#puts User.all_users
