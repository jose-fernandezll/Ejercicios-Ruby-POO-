require_relative 'modules\Autentication.rb'

class User
  @@users = []
  include Autentication
  include Roles

  def initialize(username, password, rol = 'normal')
    return puts "\e[31m ! username  or password cant be null !\e[0m" if username.empty? or password.empty?

    @user = {
      :username => username,
      :password => password,
      :rol => rol
    }

    @@users.append(@user)
    puts "\e[32mcreated user\e[0m"
  end

  def self.modify_user( new_username, new_password, old_password)
    return puts "\e[31m you need to be loged \e[0m" unless Autentication.is_loged?

    current_user = Autentication.current_user

    return puts "\e[31mIncorrect password\e[0m" unless current_user[:password] == old_password
    return puts "\e[31musername  or password cant be null\e[0m" if new_username.empty? or new_password.empty?



    @@users[current_user[:index]][:username] = new_username
    @@users[current_user[:index]][:password] = new_password

    puts "\e[32m'user modified'\e[0m"
  end

  def self.remove_user
    return puts "\e[31m you need to be loged \e[0m" unless Autentication.is_loged?
    current_user = Autentication.current_user

    @@users.delete_at(current_user[:index])
    Autentication.logout
    puts "\e[32m done!\e[0m"

  end

  def self.remove_user_admin(username)
    user_found = {}
    @@users.each_with_index do |user, index|
      if user[:username] == username
        user_found[:index] = index
      end
    end
    return puts "\e[31m User not found \e[0m" unless user_found.has_key?(:index)
    binding.irb
    @@users.delete_at(user_found[:index])
    puts "\e[32m'done!'\e[0m"
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
