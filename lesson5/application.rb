class Application
  def initialize
    @stations_list = []
    @trains_list = []
    @routes_list = []
  end

  def create_station
    puts "Название новой станции:"
    station_name = gets.chomp
    @stations_list << Station.new(station_name) if station_exist(station_name)

    print_stations
  end

  def create_train
    puts "Тип поезда (passenger/cargo):"
    type = gets.chomp.to_sym
    puts "Номер поезда:"
    train_id = gets.chomp

    if type == :passenger 
      @trains_list << PassengerTrain.new(train_id) if train_exist(train_id)
    elsif type == :cargo
      @trains_list << CargoTrain.new(train_id) if train_exist(train_id)
    else
      puts "Ошибка ввода!"
    end
    p @trains_list
  end

  def create_route
    puts "Начальная станция:"
    first_station = find_station

    puts "Конечная станция:"
    last_station = find_station

    if first_station && last_station
      @routes_list << Route.new(first_station, last_station)
      print_routes
    else
      puts "Маршрут не создан!"
    end
  end

  def assign_route
    print_routes
    if train = find_train
      train.add_route(find_route)
    end
  end
  
  def go_forward
    if train = find_train 
      train.forward
    end
  end

  def go_backward
     if train = find_train
      train.backward
     end
  end

  def hook_carriage
    if train = find_train 
      car = create_carriage(train)
      train.add_carriage(car)
    end
  end

  def unhook_carriage
    if train = find_train
      car = train.carriages.last
      train.delete_carriage(car)
    end
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
    if station = find_station
      station.trains.each{|tr| puts "Номер поезда: #{tr.id}, вагонов: #{tr.carriages.size} #{tr.object_id}"}
    end
  end

  private

  def find_train
    puts "Введите номер поезда:"
    train_number = gets.chomp
    if train = @trains_list.find{ |tr| tr.id == train_number }
      train
    else
      puts "Такого поезда не существует!"
    end
  end

  def find_route
    puts "Введите номер маршрута"
    if route = @routes_list[gets.to_i]
      route
    else
      puts "Такого маршрута не существует"
    end
  end

  def find_station
    puts "Введите название станции:"
    station_name = gets.chomp
    if station = @stations_list.find{ |st| st.name == station_name }
      station
    else
      puts "Такой станции не существует!"
    end
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

  def station_exist(station_name)
    @stations_list.find{ |st| st.name == station_name } ? (puts "Такая станция уже есть!") : station_name
  end

  def train_exist(train_id)
    @trains_list.find{ |tr| tr.id == train_id } ? (puts "Поезд с таким номером существует!") : train_id
  end
end
