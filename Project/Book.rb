require_relative 'modules\Roles.rb'
require_relative 'modules\Autentication.rb'

class Book
  @@books =
  [
    {
      title: 'Cien años de soledad', autor: 'Gabriel García Márquez',
      publication_year: '1967 ', state: 'disponible', isbn: '1001'
    },
    {
      title: '1984', autor: 'George Orwell',
      publication_year: '1949  ', state: 'disponible', isbn: '1002'
    },
    {
      title: 'El gran Gatsby', autor: ' F. Scott Fitzgerald',
      publication_year: '1925 ', state: 'disponible', isbn: '1003'
    },
    {
      title: 'Matar a un ruiseñor', autor: 'Harper Lee',
      publication_year: '1960 ', state: 'disponible', isbn: '1004'
    }

  ]
  include Roles
  include Autentication

  def initialize(title, autor, year, state,isbn)
    errors = validations(title, autor, year, state,isbn)

    return puts "\e[31m errors: #{errors}\e[0m" unless errors.empty?

    @book = {
      :title => title,
      :autor => autor,
      :publication_year => year,
      :state => state,
      :isbn => isbn
    }

    @@books.append(@book)
    puts "\e[32m successfully created book\e[0m"
  end

  def self.search(text)
    resultado = @@books.select do |libro|
      libro.any? { |clave, valor| valor.to_s.include?(text) }
    end
  end

  def self.reserve_book(isbn)
    return puts "\e[31m you need to be loged! \e[0m" unless Autentication.is_loged?

    index = find_index(isbn)

    return puts "\e[31mthere is no book with that isbn\e[0m" if index.nil?
    return puts "\e[31this book is reserved for other person\e[0m" if  @@books[index][:state].eql?('reservado')

    @@books[index][:state] = 'reservado'
    puts "\e[31myour books is reservate\e[0m"
  end

  def self.change_status_book(index)
    return puts "\e[31m you need to be loged! \e[0m" unless Autentication.is_loged?
    if @@books[index][:state] == 'reservado'
      @@books[index][:state] = "disponible"
    else
      @@books[index][:state] = "reservado"
    end
    puts "\e[32m done \e[0m"
  end

  def self.modify_book(args, index)
    binding.irb
    return puts "\e[31m you need to be loged! \e[0m" unless Autentication.is_loged?

    return puts "\e[31!you DONT have permissions!\e[0m" unless Roles.is_admin?

    #errors = validations(args[:title], args[:autor], args[:year], args[:state],args[:new_isbn])
    #return puts "\e[31m errors: #{errors}\e[0m" unless errors.empty?


    @@books[index][:title] = args[:title]unless args[:title].empty?
    @@books[index][:autor] = args[:autor] unless args[:autor].empty?
    @@books[index][:publication_year] = args[:publication_year].to_i unless args[:publication_year].empty?
    @@books[index][:state] = args[:state]
    @@books[index][:isbn] = args[:new_isbn] unless args[:new_isbn].empty?

    puts "\e[32m libro modificado correctamente\e[0m"
  end

  def self.remove_book(index)
    return puts "\e[31m you need to be loged \e[0m" unless Autentication.is_loged?
    return puts "\e[31myou DONT have permissions\e[0m" unless Roles.is_admin?

    @@books.delete_at(index)
    puts "\e[32m done \e[0m"
  end

  def self.all_books
    @@books
  end

  def self.find_index(isbn)
    index = @@books.find_index { |hash| hash[:isbn] == isbn }
    index
  end
  private
  def self.validations(title, autor, year, state,isbn)
    errors = []
    errors << "title cant be null" if title.empty?
    errors << "autor cant be null" if autor.empty?
    errors << "publication year cant be null" if year.to_s.empty?
    errors << "state cant be null" if state.empty?
    errors << "isbn cant be null" if isbn.to_s.empty?
    errors
  end
end
