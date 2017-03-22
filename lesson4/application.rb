class Application
  def initialize
    @stations_list = []
    @trains_list = []
    @routes_list = []
  end

  def create_station
    puts "Название новой станции:"
    station_name = gets.chomp

    if @stations_list.find{ |st| st.name == station_name }
      puts "Такая станция уже есть!"
    else
      @stations_list << Station.new(station_name)
    end

    print_stations
  end

  def create_train
    puts "Тип поезда (passenger/cargo):"
    type = gets.chomp.to_sym

    if type == :passenger
      puts "Номер пассажирского поезда:"
      train = PassengerTrain.new(gets.chomp)
    elsif type == :cargo
      puts "Номер грузового поезда:"
      train = CargoTrain.new(gets.chomp)
    else
      puts "Ошибка ввода!"
    end

    @trains_list << train
  end

  def create_route
    puts "Начальная станция:"
    first_station = find_station

    puts "Конечная станция:"
    last_station = find_station

    @routes_list << Route.new(first_station, last_station)
  end

  def assign_route
    print_routes
    train = find_train
    train.add_route(find_route)
  end
  
  def go_forward
     find_train.forward
  end

  def go_backward
     find_train.backward
  end

  def hook_carriage
    train = find_train
    car = create_carriage(train.type)
    train.add_carriage(car)
  end

  def unhook_carriage
    train = find_train
    car = train.carriages.last
    train.delete_carriage(car)
  end

  def change_route
    print_routes
    route = find_route
    puts "Добавить или удалить станции (add/remove):"
    answer = gets.chomp.to_sym
    if answer == :add
      route.add_station(find_station)
    elsif answer == :remove
      route.delete_station(find_station)
    end
  end

  def print_routes
    puts "Маршрутов нет!" if @routes_list.empty?
    @routes_list.each_with_index do |rt, i|
      puts "Маршрут: #{i}"
      puts "Cтанции:"
      rt.stations.each {|st| puts st.name}
    end
  end

  def print_stations
    puts "Список станций:"
    @stations_list.each{ |st| puts st.name }
  end

  def trains_on_station
    find_station.trains.each{|tr| puts "Номер поезда: #{tr.id}, тип: #{tr.id}, вагонов #{tr.carriages.size} "}
  end

  private
  #ищет поезд
  def find_train
    puts "Введите номер поезда:"
    train_number = gets.chomp
    if train = @trains_list.find{ |tr| tr.id == train_number }
      train
    else
      puts "Такого поезда не существует"
    end
  end
  #ищет маршут
  def find_route
    puts "Введите номер маршрута"
    if route = @routes_list[gets.to_i]
      route
    else
      puts "Такого маршрута не существует"
    end
  end
  #ишет станцию
  def find_station
    puts "Введите название станции"
    station_name = gets.chomp
    if station = @stations_list.find{ |st| st.name == station_name }
      station
    else
      puts "Такой станции не существует!"
    end
  end
  #создает вагон, проверяя тип
  def create_carriage(type)
    if type == :passenger
      PassengerCarriage.new
    elsif type == :cargo
      CargoCarriage.new
    end
  end

end
