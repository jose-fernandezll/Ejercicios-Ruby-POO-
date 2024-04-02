# frozen_string_literal: true

require_relative 'modules/module_autentication'
require_relative 'modules/module_roles'
# require_relative './class_user'
require 'json'

# class Book
class Book
  @@books = []
  include Roles
  include Autentication

  def initialize(title, autor, year, state, isbn)
    begin
      errors = validations(title, autor, year, state, isbn)
      raise CustomExceptions::RequireValues, "\e[31m errors:#{errors}! \e[0m" unless errors.empty?
    rescue CustomExceptions::NotLoggedInError => e
      return puts e.message
    end

    @@books.append({ title: title, autor: autor, publication_year: year, state: state, isbn: isbn })

    puts "\e[32m successfully created book\e[0m"
  end

  def self.search(text)
    @@books.select do |libro|
      libro.any? { |_clave, valor| valor.to_s.include?(text) }
    end
  end

  def self.reserve_book(isbn)
    begin
      Autentication.check_logged_in
    rescue CustomExceptions::NotLoggedInError => e
      return puts e.message
    end

    index = find_index(isbn)

    return puts "\e[31m there is no book with that isbn\e[0m" if index.nil?
    return puts "\e[31m this book is reserved for other person\e[0m" if @@books[index][:state].eql?('reservado')

    @@books[index][:state] = 'reservado'
    puts "\e[32myour books is reservate\e[0m"
  end

  def self.change_status_book(index)
    begin
      Autentication.check_logged_in
    rescue CustomExceptions::NotLoggedInError => e
      return puts e.message
    end

    @@books[index][:state] = @@books[index][:state] == 'reservado' ? 'disponible' : 'reservado'
    puts "\e[32m done \e[0m"
  end

  def self.modify_book(args, index)
    begin
      Autentication.check_logged_in
      Roles.check_admin
    rescue CustomExceptions::NotLoggedInError, CustomExceptions::NotAdminError => e
      puts e.message
      return
    end

    update_book(args, index)

    puts "\e[32m libro modificado correctamente\e[0m"
  end

  def self.update_book(args, index)
    @@books[index].each_key do |key|
      @@books[index][key] = args[key] unless args[key].empty?
    end
  end

  def self.remove_book(index)
    begin
      Autentication.check_logged_in
      Roles.check_admin
    rescue CustomExceptions::NotLoggedInError, CustomExceptions::NotAdminError => e
      puts e.message
      return
    end

    @@books.delete_at(index)
    puts "\e[32m done \e[0m"
  end

  def self.all_books
    @@books
  end

  def self.all_books_new(books)
    @@books = books unless books.empty?
  end

  def self.find_index(isbn)
    @@books.find_index { |hash| hash[:isbn] == isbn }
  end

  private

  def validations(title, autor, year, state, isbn)
    errors = []
    errors << 'title cant be null' if title.empty?
    errors << 'autor cant be null' if autor.empty?
    errors << 'publication year cant be null' if year.to_s.empty?
    errors << 'state cant be null' if state.empty?
    errors << 'isbn cant be null' if isbn.to_s.empty?
    errors
  end
end

# Book.new('jumaji', 'dont knwo', 2022, 'disponible', '1008')
#
# puts Book.all_books
# args = {
#   title: 'Into the Jungle',
#   autor: 'Dont Follow me',
#   publication_year: 2025,
#   state: 'disponible',
#   isbn: '20014'
# }
# User.new('jose', '1212')
# Autentication.login(User.all_users, 'jose', '1212')
# puts Book.modify_book(args, 0)
# puts Book.change_status_book(0)
# puts Book.all_books
# puts Book.change_status_book(0)
# puts Book.all_books
