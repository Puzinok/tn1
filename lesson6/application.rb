class Application
  def initialize
    @stations_list = []
    @trains_list = []
    @routes_list = []
  end

  def create_station
    puts "Название новой станции:"
    station_name = gets.chomp
    @stations_list << Station.new(station_name)
  rescue RuntimeError => e
    p e
    print_stations
  retry
  end

  def create_train
    puts "Тип поезда (passenger/cargo):"
    type = gets.chomp.to_sym
  raise "Неверный тип поезда!" if type != :passenger && type != :cargo
    puts "Номер поезда:"
    train_id = gets.chomp
    @trains_list << PassengerTrain.new(train_id) if type == :passenger
    @trains_list << CargoTrain.new(train_id) if type == :cargo

    puts "Создан поезд № #{train_id}, тип: #{type}."
  rescue RuntimeError => e
    p e
  retry
  end

  def create_route
    puts "Начальная станция:"
    first_station = find_station
    puts "Конечная станция:"
    last_station = find_station
    new_route = Route.new(first_station, last_station)
    @routes_list << new_route if new_route.valid?
  rescue RuntimeError => e
    p e
    puts "Маршрут не создан!"
  retry
  end

  def assign_route
    print_routes
    find_train.add_route(find_route)
  rescue RuntimeError => e
    p e
  end
  
  def go_forward
    train = find_train
    train.forward
    raise "У поезда нет маршрута!" if train.route.nil?
  rescue RuntimeError => e
    p e
  end

  def go_backward
    train = find_train
    train.backward
    raise "У поезда нет маршрута!" if train.route.nil?
  rescue RuntimeError => e
    p e
  end

  def hook_carriage
    train = find_train
    car = create_carriage(train)
    train.add_carriage(car)
  rescue RuntimeError => e
    p e
  end

  def unhook_carriage
    train = find_train
    car = train.carriages.last
    train.delete_carriage(car)
  rescue RuntimeError => e
    p e
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
    else
      puts "Ошибка ввода!"
    end
  rescue RuntimeError => e
    p e
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
    station = find_station
    station.trains.each{|tr| puts "Номер поезда: #{tr.id}, вагонов: #{tr.carriages.size}"}
  rescue RuntimeError => e
    p e
  end

  private

  def find_train
    puts "Введите номер поезда:"
    train_id = gets.chomp
    train = Train.find(train_id)
    raise "Такого поезда не существует!" if train.nil?
    train
  end

  def find_route
    puts "Введите номер маршрута:"
    route = @routes_list[gets.to_i]
    raise "Такого маршрута не существует!" if route.nil?
    route
  end

  def find_station
    puts "Введите название станции:"
    station_name = gets.chomp
    station = Station.all.find{|st| st.name == station_name}
    raise "Такой станции не существует!" if station.nil?
    station
  end

  def create_carriage(train)
    if train.instance_of? PassengerTrain
      PassengerCarriage.new
    elsif train.instance_of? CargoTrain
      CargoCarriage.new
    else
      puts "Неизвестный тип поезда!"
    end
  end
end
