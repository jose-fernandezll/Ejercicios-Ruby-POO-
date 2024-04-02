# frozen_string_literal: true

require_relative './module_custom_exceptions'

# Module Autentication
module Autentication
  include CustomExceptions
  @@current_user = {}

  def self.login(users, username, password)
    user = find_user(users, username)

    return puts "\e[31m ! no account exists with that username ! \e[0m" unless user.key?(:user)

    @@current_user[:user] = user[:user] if user[:user][:password] == password
    @@current_user[:index] = user[:index]

    return puts "\e[31m'username or password wrong!'\e[0m" unless loged?

    puts "\e[32m'successful login!'\e[0m" if loged?
  end

  def self.logout
    @@current_user = {}
  end

  def self.loged?
    @@current_user.key?(:user)
  end

  def self.check_logged_in
    raise CustomExceptions::NotLoggedInError, "\e[31m you need to be loged! \e[0m" unless Autentication.loged?
  end

  def self.current_user
    @@current_user
  end

  def self.find_user(users, username)
    user_found = {}
    users.each_with_index do |user, index|
      if user[:username] == username
        user_found[:user] = user
        user_found[:index] = index
        return user_found
      end
    end
    user_found
  end
end
