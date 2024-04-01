# frozen_string_literal: true

require_relative 'module_autentication'
require_relative 'module_custom_exceptions'

# Module Roles
module Roles
  include Autentication
  include CustomExceptions

  def self.admin?
    user = Autentication.current_user
    user[:rol] == 'admin'
  end

  def self.check_admin
    raise CustomExceptions::NotAdminError, "\e[31m you DONT have permissions!\e[0m" unless Roles.admin?
  end
end
