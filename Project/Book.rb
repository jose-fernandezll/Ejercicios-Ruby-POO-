class Book
  @@books = []

  def initialize(title, autor, year, state,isbn)
    errors = validations(title, autor, year, state,isbn)
    return puts "#{errors}" unless errors.empty?

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
    errors = validations(title, autor, year, state,isbn)
    return puts "#{errors}" unless errors.empty?

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

   def validations(title, autor, year, state,isbn)
      errors = []

      errors << "title cant be null" if title.empty?
      errors << "autor cant be null" if autor.empty?
      errors << "publication year cant be null" if year.to_s.empty?
      errors << "state cant be null" if state.empty?
      errors << "isbn cant be null" if isbn.to_s.empty?

      errors
   end
end
