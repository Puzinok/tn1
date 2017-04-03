class Application
  attr_accessor :stations_list

  def initialize
    @stations_list = []
    @trains_list = []
    @routes_list = []
  end

  def navigation(choise, options)
    options[choise] ? send(options[choise]) : (puts 'Ошибка ввода!')
  end

  def create_station
    puts 'Название новой станции:'
    station_name = gets.chomp
    @stations_list << Station.new(station_name)
  rescue RuntimeError => e
    p e
    print_stations
    retry
  end

  def create_train
    puts 'Тип поезда (passenger/cargo):'
    type = gets.chomp.to_sym
    puts 'Номер поезда:'
    train_id = gets.chomp
    add_train(train_id, type)
  rescue RuntimeError => e
    p e
    retry
  end

  def create_route
    puts 'Начальная станция:'
    first_station = find_station
    puts 'Конечная станция:'
    last_station = find_station
    new_route = Route.new(first_station, last_station)
    @routes_list << new_route if new_route.valid?
  rescue RuntimeError => e
    p e
    puts 'Маршрут не создан!'
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
    raise 'У поезда нет маршрута!' if train.route.nil?
  rescue RuntimeError => e
    p e
  end

  def go_backward
    train = find_train
    train.backward
    raise 'У поезда нет маршрута!' if train.route.nil?
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
    puts 'Добавить или удалить станции (add/remove):'
    modify_route(route, gets.chomp.to_sym)
  rescue RuntimeError => e
    p e
  end

  def print_routes
    puts 'Маршрутов нет!' if @routes_list.empty?
    @routes_list.each_with_index do |rt, i|
      puts "Маршрут: #{i}"
      puts 'Cтанции:'
      rt.stations.each { |st| puts st.name }
    end
  end

  def trains_on_station
    station = find_station
    station.each_train do |t|
      puts "№ #{t.id}, тип: #{t.class}, вагонов: #{t.carriages.size}"
    end
  rescue RuntimeError => e
    p e
  end

  def cars_of_train
    train = find_train
    i = 0
    train.each_carriage do |c|
      puts "#{i += 1}. #{c}"
    end
  rescue RuntimeError => e
    p e
  end

  def print_stations
    @stations_list.each do |s|
      puts s.name
      s.each_train { |t| puts "   № #{t.id}, тип: #{t.class}, вагонов: #{t.carriages.size}" }
    end
  end

  def load_carriage
    carriage = find_carriage
    if carriage.is_a? CargoCarriage
      puts "Объем: #{carriage.free_capacity}. Введите сколько заполнить:"
      carriage.use_capacity(gets.to_i)
    elsif carriage.is_a? PassengerCarriage
      carriage.take_seat
    end
    puts carriage
  rescue RuntimeError => e
    p e
  end

  private

  def modify_route(route, action)
    if action == :add
      route.add_station(find_station)
    elsif action == :remove
      route.delete_station(find_station)
    else
      puts 'Ошибка ввода!'
    end
  end

  def add_train(id, type)
    raise 'Неверный тип поезда!' unless type == :passenger || type == :cargo
    if type == :passenger
      @trains_list << PassengerTrain.new(id)
    elsif type == :cargo
      @trains_list << CargoTrain.new(id)
    end
    puts "Создан поезд № #{id}, тип: #{type}."
  end

  def find_carriage
    train = find_train
    puts 'Введите номер вагона:'
    carriage = train.carriages[gets.to_i - 1]
    raise 'Такого вагона не существует!' if carriage.nil?
    carriage
  end

  def find_train
    puts 'Введите номер поезда:'
    train_id = gets.chomp
    train = Train.find(train_id)
    raise 'Такого поезда не существует!' if train.nil?
    train
  end

  def find_route
    puts 'Введите номер маршрута:'
    route = @routes_list[gets.to_i]
    raise 'Такого маршрута не существует!' if route.nil?
    route
  end

  def find_station
    puts 'Введите название станции:'
    station_name = gets.chomp
    station = Station.all.find { |st| st.name == station_name }
    raise 'Такой станции не существует!' if station.nil?
    station
  end

  def create_carriage(train)
    if train.is_a? PassengerTrain
      puts 'Введите количество мест в вагоне:'
      PassengerCarriage.new(gets.chomp)
    elsif train.is_a? CargoTrain
      puts 'Введите объем вагона:'
      CargoCarriage.new(gets.chomp)
    else
      puts 'Неизвестный тип поезда!'
    end
  end
end
