module Autentication
  @@current_user = {}
  def self.login(users,username, password)
    user = find_user(users,username)
    return 'no account exists with that username' if user.empty?

    @@current_user = user if user[:password] == password

    return "successful login!"
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
    users.each_with_index do |user, index|
      if user[:username] == username
        user[:index] = index
        return user
      end
    end
  end
end
