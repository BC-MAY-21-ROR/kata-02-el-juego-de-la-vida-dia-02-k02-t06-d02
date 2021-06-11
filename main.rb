# frozen_string_literal: true

# Clase para construir matriz
class Matrix
  def initialize(ancho, largo)
    @ancho = ancho
    @largo = largo
    @grid = []
  end

  def build
    @ancho.times do |_i|
      @grid.push([])
    end
    llenar
  end

  def llenar
    @grid.each do |i|
      @largo.times do |_x|
        if rand(2).zero?
          i.push(' ° ')
        else
          i.push(' * ')
        end
      end
    end
    @grid
  end
end

# Clase para mostrar matriz con herencia de Matrix
class Show < Matrix
  def initialize(ancho, largo, grid)
    super(ancho, largo)
    @grid = grid
  end

  def show
    (0..@ancho - 1).each do |i|
      cadena = ''
      (0..@largo - 1).each do |x|
        cadena += @grid[i][x]
      end
      puts cadena
    end
  end
end

# Clase para cumplir condiciones
class Condiciones < Matrix
  def initialize(ancho, largo, grid)
    super(ancho, largo)
    @grid = grid
  end

  # Metodo para matar celulas vivas que se encuentren en las orillas
  def matar_bordes
    (0..@ancho - 1).each do |i|
      (0..@largo - 1).each do |x|
        @grid[i][x] = ' ° ' if i.zero? || i == @ancho - 1 || x.zero? || x == @largo - 1
      end
    end
  end

  def conteo
    (1..@ancho - 2).each do |i|
      cadena = ''
      (1..@largo - 2).each do |x|
        @conteo_celulas_vivas = 0
        validar_vecinos(i, x)
        cadena = @grid[i][x]
      end
    end
  end

  def validar_vecinos(ejei, ejex)
    # Contando vecinos vivo alrededor de cada celula
    # cadena += validar_vecinos(i,x).to_s
    @conteo_celulas_vivas += 1 if @grid[ejei - 1][ejex - 1] == ' * '
    @conteo_celulas_vivas += 1 if @grid[ejei - 1][ejex] == ' * '
    @conteo_celulas_vivas += 1 if @grid[ejei - 1][ejex + 1] == ' * '
    @conteo_celulas_vivas += 1 if @grid[ejei][ejex - 1] == ' * '
    @conteo_celulas_vivas += 1 if @grid[ejei][ejex + 1] == ' * '
    @conteo_celulas_vivas += 1 if @grid[ejei + 1][ejex - 1] == ' * '
    @conteo_celulas_vivas += 1 if @grid[ejei + 1][ejex] == ' * '
    @conteo_celulas_vivas += 1 if @grid[ejei + 1][ejex + 1] == ' * '
    condiciones(ejei, ejex)
  end

  def condiciones(ejei, ejex)
    # Condicion para celula viva con mas de 3 vecinos
    @grid[ejei][ejex] = ' ° ' if @conteo_celulas_vivas > 3 && @grid[ejei][ejex] == ' * '

    # Condicion para celula muerta con 3 vecinos
    @grid[ejei][ejex] = ' * ' if @conteo_celulas_vivas == 3 && @grid[ejei][ejex] == ' ° '

    # Condicion para celula viva con menos de 2 vecinos
    @grid[ejei][ejex] = ' ° ' if @conteo_celulas_vivas < 2 && @grid[ejei][ejex] == ' * '
  end
end

# Llamando a la clase Main
class Main
  # Obtener medidas del grid
  puts 'Ingrese ancho: '
  ancho_temp = gets.to_i
  puts 'Ingrese largo: '
  largo_temp = gets.to_i

  # Creacion de objeto de la clase Matrix
  matrix = Matrix.new(ancho_temp, largo_temp)

  # Obtencion de la matriz creada en Matrix para pasar el valor a las otras clases
  matriz = matrix.build

  # Creacion de objeto de la clase Show
  show_class = Show.new(ancho_temp, largo_temp, matriz)
  puts '1ra Generacion'
  show_class.show

  # Creacion de objeto de la clase Condiciones
  condiciones = Condiciones.new(ancho_temp, largo_temp, matriz)
  condiciones.matar_bordes
  condiciones.conteo
  puts '2da Generacion'
  show_class.show
end

object = Main.new
