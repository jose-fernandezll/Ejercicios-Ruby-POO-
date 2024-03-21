require_relative 'modules\Roles.rb'
require_relative 'modules\Autentication.rb'
require_relative 'User.rb'
require_relative 'Book.rb'

def menu(rol)

  case rol
    when 'basic'
      puts "----------------------------------------------------------------------"
      puts "-                         RESERVATION SYSTEM                         -"
      puts "-                                                                    -"
      puts "- (1)Login                                                           -"
      puts "- (2)Crear Usuario                                                   -"
      puts "- (3)Buscar libros                                                   -"
      puts "- (4)Ver Libros                                                      -"
      puts "-                                                                    -"
      puts "----------------------------------------------------------------------"
    when 'medium'
      puts "----------------------------------------------------------------------"
      puts "-                         RESERVATION SYSTEM                         -"
      puts "-                                                                    -"
      puts "- (1)Ver Libros                                                      -"
      puts "- (2)Buscar libros                                                   -"
      puts "- (3)Reservar Libros                                                 -"
      puts "- (4)Modificar Cuenta                                                -"
      puts "- (4)Eliminar Cuenta                                                 -"
      puts "- (4)Cerrar sesion                                                   -"
      puts "-                                                                    -"
      puts "----------------------------------------------------------------------"
    when 'advanced'
      puts "----------------------------------------------------------------------"
      puts "-                         RESERVATION SYSTEM                         -"
      puts "-                                                                    -"
      puts "- (1)Ver Libros                                                      -"
      puts "- (2)Buscar libros                                                   -"
      puts "- (3)Agregar Libros                                                  -"
      puts "- (4)Eliminar Libros                                                 -"
      puts "- (5)Modificar Libros                                                -"
      puts "- (6)Modificar Estado Libro                                          -"
      puts "- (7)Ver Reservas                                                    -"
      puts "- (8)Ver Usuarios                                                    -"
      puts "- (9)Modificar Usuario                                               -"
      puts "- (10)Eliminar Usuarios                                              -"
      puts "- (11)Eliminar Cuenta                                                -"
      puts "- (12)Cerrar sesion                                                  -"
      puts "-                                                                    -"
      puts "----------------------------------------------------------------------"
  end
end


loop do
  menu('basic') unless Autentication.is_loged?
  menu('medium') unless Autentication.is_loged? and Roles.is_admin?
  menu('advanced') if Autentication.is_loged? and Roles.is_admin?
  Opcion = gets.chomp

end
