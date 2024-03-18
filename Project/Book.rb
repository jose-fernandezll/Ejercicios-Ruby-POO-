class Book
  @@books = []

  def initialize(title, autor, year, state,isbn)
    @book = {
      :title => title,
      :autor => autor,
      :publication_year => year,
      :state => state,
      :isbn => isbn
    }

    @@books.append(@book)
  end

  def self.search(text)
    resultado = libros.select do |libro|
      libro.any? { |clave, valor| valor.to_s.include?(text) }
    end
  end

  def self.reserve_book(isbn)
    index = find_index(isbn)
    return puts 'this book is reserved for other person' if  @@books[index][:state].eql?('reservado')

    @@books[index][:state] = 'reservado'
    puts 'your books is reservate'
  end

  def self.modify_book(title, autor, year, state,isbn)
    index = find_index(isbn)

    @@books[index][:title] = title
    @@books[index][:autor] = autor
    @@books[index][:publication_year] = year
    @@books[index][:state] = state
    @@books[index][:isbn] = isbn

    puts 'libro modificado correctamente'
  end

  def self.remove_book(isbn)
    index = find_index(isbn)

    @@books.delete_at(index)
    puts 'done'
  end

  def self.all_books
    @@books
  end

  private
   def self.find_index(isbn)
    index = @@books.find_index { |hash| hash[:isbn] == isbn }
    index
   end
end

#Book.new('more dark', 'leb-luttor', 2015, 'reservado',00001)
#
#Book.reserve_book(00001)
#Book.modify_book(00001)
#
#puts Book.all_books
#Book.remove_book(00001)
#Book.new('mordark', 'lex-lator', 2012, 'ocupado')
#Book.new('madark', 'libluttor', 2013, 'ocupado')
#
#libros = Book.all_books
#
#puts "this is your books #{libros}"
#
#binding.irb
#
#resultado = libros.select { |hash| hash[:state] == 'ocupado' }
#
#busqueda = 'dark'
#resultado = libros.select do |hash|
#  hash.any? { |clave, valor| valor.to_s.include?(busqueda) }
#end
#
#puts "this is what you was looking for #{resultado.length} "