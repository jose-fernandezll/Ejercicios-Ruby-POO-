# frozen_string_literal: true

require_relative 'modules\module_autentication'
require 'json'

# Class User
class User
  @@users = []
  include Autentication
  include Roles

  def initialize(username, password, rol = 'normal')
    return puts "\e[31m ! username  or password cant be null !\e[0m" if username.empty? || password.empty?

    @@users.append({ username: username, password: password, rol: rol })

    puts "\e[32mcreated user\e[0m"
  end

  def self.modify_user(new_username, new_password, old_password)
    begin
      Autentication.check_logged_in
    rescue CustomExceptions::NotLoggedInError, CustomExceptions::NotAdminError => e
      return puts e.message
    end

    return puts "\e[31mIncorrect password\e[0m" unless Autentication.current_user[:password] == old_password

    return puts "\e[31musername  or password cant be null\e[0m" if new_username.empty? || new_password.empty?

    update_user(Autentication.current_user[:index], new_password, new_username)

    puts "\e[32m'user modified'\e[0m"
  end

  def update_user(index, new_password, new_username)
    @@users[index][:username] = new_username
    @@users[index][:password] = new_password
  end

  def self.remove_user
    return puts "\e[31m you need to be loged \e[0m" unless Autentication.is_loged?

    current_user = Autentication.current_user

    @@users.delete_at(current_user[:index])
    Autentication.logout
    puts "\e[32m done!\e[0m"
  end

  def self.remove_user_admin(username)
    user_found = find_user_index(username)
    return puts "\e[31m User not found \e[0m" unless user_found.key?(:index)

    @@users.delete_at(user_found[:index])
    puts "\e[32m'done!'\e[0m"
  end

  def self.all_users
    @@users
  end

  def self.all_users_new(users)
    @@users = users unless users.empty?
  end

  def find_user_index(username)
    @@users.each_with_index do |user, index|
      return user_found[:index] = index if user[:username] == username
    end
  end
end


# User.new('jose','121415', 'admin')
# users = User.all_users
#
# Autentication.login(users,'jose', '121415')
# User.modify_user('jose-ismael','121415')
# puts User.all_users
