module Autentication
  @@current_user = {}
  def self.login(users,username, password)
    user = find_user(users,username)
    @@current_user = user if user[:password] == password

    return puts "logeado : #{@@current_user}"
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
    user = users.find { |user| user[:username] == username }
    user
  end
end
