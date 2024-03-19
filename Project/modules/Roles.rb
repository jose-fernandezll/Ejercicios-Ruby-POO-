require_relative 'Autentication.rb'
module Roles
  include Autentication

  def self.is_admin?
    user = Autentication.current_user
    user[:rol] == "admin"
  end
end
