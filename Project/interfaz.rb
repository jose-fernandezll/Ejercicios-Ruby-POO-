require_relative 'modules/module_roles'
require_relative 'modules/module_autentication'
require_relative 'class_user'
require_relative 'class_book'
require 'json'


# metodos helpers

def ver_libros
  libros = Book.all_books

  longest_key = libros.first.keys.max_by(&:length).length
  longest_value = libros.flat_map(&:values).max_by(&:length).length

  imprimir_libro(libros, longest_key ,longest_value)
end

def imprimir_libro(libros, longest_key ,longest_value)
  libros.each do |libro|
    puts '-' * (longest_key + longest_value + 7)
    libro.each do |key, value|
      puts "| #{key.to_s.ljust(longest_key)}: #{value.rjust(longest_value)} |"
    end
    puts '-' * (longest_key + longest_value + 7)
  end
end

def buscar_libros
  puts "busqueda por titulo, autor y año ej:('habitos atomicos'): "
  text = gets.chomp.to_s
  libros = Book.search(text)

  return puts 'not found' if libros.empty?

  longest_key = libros.first.keys.max_by(&:length).length
  longest_value = libros.flat_map(&:values).max_by(&:length).length

  imprimir_libro(libros, longest_key, longest_value)
end

def guardar_libros
  File.open('Ejercicios-Ruby-POO/project/data_books.json','w') do |f|
    libros = Book.all_books
    f.write(libros.to_json)
  end
end

def guardar_usuarios
  File.open('Ejercicios-Ruby-POO/project/data_users.json','w') do |f|
    usuarios = User.all_users
    f.write(usuarios.to_json)
  end
end

def reservar_libros
  puts 'cuantos libros desea reservar: '
  cantidad = gets.chomp.to_i

  cantidad.times do |i|
    puts "type isbn of the #{i} book:"
    isbn = gets.chomp.to_i
    Book.reserve_book(isbn)
  end
end

def modificar_usuario
  puts 'type the new Username: '
  username = gets.chomp
  puts 'type the new Password: '
  password = gets.chomp.to_s

  puts 'type the old Password: '
  old_password = gets.chomp.to_s

  User.modify_user(username, password, old_password)
end

def convertir_tosymbol(data)
  datos_simbolos = data.map do |hash|
    hash.transform_keys(&:to_sym)
  end
end

def cargar_datos_libros
  data = []
  File.open('Ejercicios-Ruby-POO/Project/data_books.json','r') do |f|
    libros = f.read
    data = JSON.parse(libros) unless libros.empty?
  end
  datos_simbolos = convertir_tosymbol(data)

  Book.all_books_new(datos_simbolos)
end

def cargar_datos_users
  data = []
  File.open('Ejercicios-Ruby-POO/Project/data_users.json','r') do |f|
    users = f.read
    data = JSON.parse(users) unless users.empty?
  end
  users = convertir_tosymbol(data)
  User.all_users_new(users)

end

MENUS = {
  'basic' => [
    '(1)Login', '(2)Crear Usuario', '(3)Buscar libros', '(4)Ver Libros', '(5)salir'
  ],
  'medium' => [
    '(1)Ver Libros', '(2)Buscar libros', '(3)Reservar Libros', '(4)Modificar Cuenta',
    '(5)Eliminar Cuenta', '(6)Cerrar sesion', '(7)salir'
  ],
  'advanced' => [
    '(0)Ver Libros', '(1)Buscar libros', '(2)Agregar Libros', '(3)Eliminar Libros',
    '(4)Modificar Libros', '(5)Modificar Estado Libro', '(6)Ver Reservas',
    '(7)Ver Usuarios', '(8)Modificar Usuario', '(9)Eliminar Usuarios', '(10)Eliminar Cuenta',
    '(11)Cerrar sesion', '(12)salir'
  ]
}.freeze

def menu(rol)
  puts '----------------------------------------------------------------------'
  puts '-                         RESERVATION SYSTEM                         -'
  puts '-                                                                    -'
  MENUS[rol].each { |option| puts "- #{option}" }
  puts '-                                                                    -'
  puts '----------------------------------------------------------------------'
end


# inicio de interfaz

loop do
  system 'cls'
  cargar_datos_libros
  cargar_datos_users
  unless Autentication.loged?
    menu('basic')
    opcion = gets.chomp.to_i
    case opcion
    when 1
      print 'Username: '
      username = gets.chomp
      print 'Password: '
      password = gets.chomp.to_s
      Autentication.login(User.all_users, username, password)
      sleep(2)
    when 2
      print 'Type Username: '
      username = gets.chomp
      print 'Type Password: '
      password = gets.chomp.to_s
      user = Autentication.find_user(User.all_users, username)
      if user.empty?
        User.new(username, password)
        guardar_usuarios
      else
        puts "\e[31m that username exist\e[0m"
      end
      sleep(2)
    when 3
      buscar_libros
      print "\e[32m Presiona enter para continuar\e[0m"
      gets
      sleep(2)
    when 4
      ver_libros
      print "\e[32m Presiona enter para continuar\e[0m"
      gets
      sleep(2)
    when 5
      print "\e[32m Saliendo, Gracias por usar este programa!\e[0m"
      sleep(1)
      break
    when 777
      puts 'Type Username: '
      username = gets.chomp
      puts 'Type Password: '
      password = gets.chomp.to_s
      user = Autentication.find_user(User.all_users,username)
      if user.empty?
        puts User.new(username, password, 'admin')
        guardar_usuarios
      else
        puts "\e[31m that username exist\e[0m"
      end
      sleep(2)
    end
  end
  system 'cls'

  if Autentication.loged? && !Roles.admin?
    menu('medium')
    opcion = gets.chomp.to_i

    case opcion
    when 1
      ver_libros
      print "\e[32m Presiona enter para continuar\e[0m"
      gets
      sleep(2)
    when 2
      buscar_libros
      print "e[32m Presiona enter para continuar\e[0m"
      gets
      sleep(2)
    when 3
      reservar_libros
      guardar_libros
      print "\e[32m done\e[0m"
      sleep(2)
    when 4
      modificar_usuario
      guardar_usuarios
      sleep(2)
    when 5
      User.remove_user
      guardar_usuarios
      sleep(1)
    when 6
      Autentication.logout
    when 7
      break
    end
  end

  next unless Autentication.loged? && Roles.admin?

  menu('advanced')
  opcion = gets.chomp.to_i

  case opcion
  when 0
      ver_libros
      print "\e[32m Presiona enter para continuar\e[0m"
      gets
      sleep(2)
  when 1
      buscar_libros
      print "\e[32m Presiona enter para continuar\e[0m"
      gets
      sleep(2)
  when 2
      puts 'cuantos libros desea crear: '
      cantidad = gets.chomp.to_i

      cantidad.times do |i|
        puts "type the title of the book #{i}"
        title = gets.chomp
        puts "type the autor of the book #{i}"
        autor = gets.chomp
        puts "type the publication year of the book #{i}"
        year = gets.chomp.to_i
        puts "type the state of the book #{i} only('disponible' or 'reservado')"
        state = ''
        loop do
          puts "Por favor, ingresa 'disponible' o 'reservado':"
          state = gets.chomp.downcase
          break if %w(disponible reservado).include?(state)

          puts "\e[31mEntrada inválida. Intenta de nuevo.\e[0m"
        end
        puts "type the isbn of the book #{i}"
        isbn = gets.chomp.to_s
        Book.new(title, autor, year, state, isbn)
        sleep(1)
      end
      guardar_libros
      sleep(1)
  when 3
      puts 'how many books do you wanna delete: '
      cantidad = gets.chomp.to_i
      cantidad.times do |i|
        puts "type the isbn of the #{i} book"
        isbn = gets.chomp.to_s
        index = Book.find_index(isbn)
        if index.nil?
          puts "\e[31mthere is no book with that isbn\e[0m"
        else
          Book.remove_book(index)
          sleep(2)
        end
      end
      guardar_libros
      sleep(1)
  when 4
      args = {}
      puts 'type the isbn of the book that you want to update'
      old_isbn = gets.chomp.to_s
      puts "\e[32m if u dont want to update some data just enter to skip!\e[0m"
      index = Book.find_index(old_isbn)
      if index.nil?
        puts "\e[31mthere is no book with that isbn\e[0m"
      else
        puts 'type the new isbn of the book'
        args[:new_isbn] = gets.chomp.to_s
        puts 'type the title of the book'
        args[:title] = gets.chomp
        puts 'type the autor of the book'
        args[:autor] = gets.chomp
        puts 'type the publication year of the book'
        args[:publication_year] = gets.chomp.to_s
        puts "type the state of the book only('disponible' or 'reservado')"
        state=''
        loop do
          puts "Por favor, ingresa 'disponible' o 'reservado':"
          state = gets.chomp.downcase
          break if %w("disponible reservado).include?(state)

          puts "\e[31mEntrada inválida. Intenta de nuevo.\e[0m"
        end
        args[:state] = state
        Book.modify_book(args, index)
        guardar_libros
        sleep(2)
      end
  when 5
      puts 'type the isbn: '
      isbn = gets.chomp.to_s
      index = Book.find_index(isbn)
      if index.nil?
        puts "\e[31mthere is no book with that isbn\e[0m"
      else
        Book.change_status_book(index)
        guardar_libros
      end
      sleep(2)
  when 6
      puts Book.search('reservado')
      print "\e[32m Presiona enter para continuar\e[0m"
      gets
      sleep(2)
  when 7
      puts User.all_users
      print "\e[32m Presiona enter para continuar\e[0m"
      gets
      sleep(2)
  when 8
      modificar_usuario
      guardar_usuarios
      sleep(1)
  when 9
      puts 'type the username: '
      username = gets.chomp
      User.remove_user_admin(username)
      guardar_usuarios
      sleep(1)
  when 10
      User.remove_user
      guardar_usuarios
      sleep(1)
  when 11
      Autentication.logout
  when 12
      break
  end
end
