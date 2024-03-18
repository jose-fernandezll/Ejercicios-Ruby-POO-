require_relative 'modules\Autentication.rb'
class User
  @@users = []
  def initialize(username, password, rol)
    @user = {
      :username => username,
      :password => password,
      :rol => rol
    }

    @@users.append(@user)
  end

  def self.modify_user(current_user, username, password, rol)
    index = find_user(current_user[:username])

    @@users[index][:username] = username
    @@users[index][:password] = password
    @@users[index][:rol] = rol

    puts "user modified"
  end

  def self.remove_user(current_user)
    index = find_user(current_user[:username])

    @@users.delete_at(index)
    puts "done"
  end

  def self.all_users
    #validacion rol proximamente
    @@users
  end

  private

  def self.find_user(username)
    index = @@users.find_index { |user| user[:username] == username }
    index
  end
end


#User.new('pacoporros', 'pacoelporros','normal')
#puts "all users #{User.all_users} "
#puts ""
#
#user = {username: 'pacoporros', password: 'pacoelporros'}
#User.modify_user(user, 'paco-porros', 'paco-el-porros', 'admin')
#puts "all users but one modified #{User.all_users} "
#puts""
#
#user = {username: 'paco-porros', password: 'paco-el-porros'}
#User.remove_user(user)
#puts "#{User.all_users}"
#users = User.all_users
#Autentication.login(users,'paco-porros','paco-el-porros')
#
#puts "this is the current user: #{Autentication.current_user}"
#Autentication.logout
#puts "this is the current user: #{Autentication.current_user}"
#puts "is loged? #{Autentication.is_loged?}"

