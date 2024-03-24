module Autentication
  @@current_user = {}
  def self.login(users,username, password)
    user = find_user(users,username)
    return puts "\e[31m ! no account exists with that username ! \e[0m" if user.empty?
    binding.irb
    @@current_user = user if user[:password] == password

    return puts "\e[31m'username or password wrong!'\e[0m" if !is_loged?
    return puts "\e[32m'successful login!'\e[0m" if is_loged?
  end

  def self.logout
    @@current_user = {}
  end

  def self.is_loged?
    @@current_user.has_key?(:username)
  end

  def self.current_user
    @@current_user
  end

  private

  def self.find_user(users,username)
    binding.irb
    users.each_with_index do |user, index|
      if user[:username] == username
        user[:index] = index
        return user
      end
    end
  end
end
