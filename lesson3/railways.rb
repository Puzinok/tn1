class Station

  attr_reader :name

  def initialize(name)
    @trains = []
    @name = name
  end

  def arrive(train)
    @trains << train
  end

  def departure(train)
    @trains.delete(train)
  end

  def all_trains
    @trains.each do |t|
      puts "Поезд: #{t.train[0]}, Тип: #{t.train[1]}, Вагонов: #{t.train[2]}"
    end
  end

  def trains_by_type
    p_train = 0
    @trains.each.with_index(1) do |t, i|
     p_train = i if t.train[1] == "people"
    end
    puts "Пассажирских: #{p_train}, Грузовых: #{@trains.size - p_train} "
  end

end

class Route
  attr_reader :stations

  def initialize(first_st, last_st)
    @stations = [first_st, last_st]
  end

  def add_st(station)
    @stations.insert(-2, station)
  end

  def del_st(station)
    if station != @stations.last && station != @stations.first
      @stations.delete(station)
    end
  end

  def show
    @stations.each.with_index(1){|st, i| puts "#{i}. #{st.name}"}
  end

end


class Train
  attr_reader :train

  def initialize(id, type, cars)
    @train = [id, type, cars.to_i]
    @speed = 0
  end

  def speed_up(num)
    @speed += num
  end

  def current_speed
    puts "Скорость поезда #{@speed}"
  end
  
  def brake
    @speed = 0
  end

  def cars
    puts "Вагонов: #{@train[2]}"
  end

  def add_car
    @train[2] += 1 if @speed == 0
  end 

  def del_car
    @train[2] -= 1 if @speed == 0
  end

  def add_route(route)
    @route = route
    @station = @route.stations[0]
    @station.arrive(self)
  end

  def motion(direction)
    @station.departure(self)
    current = @route.stations.index(@station)
    if direction == "forward"
      @station = @route.stations[current + 1]
    else
      @station = @route.stations[current - 1]
    end
    @station.arrive(self)
  end

  def forward
    motion("forward") if @station != @route.stations.last
  end

  def backward
    motion("back") if @station != @route.stations.first
  end
  
  def current_st
    puts @station.name
  end

  def next_st
    puts @route.stations[@route.stations.index(@station) + 1].name
  end

  def prev_st
    puts @route.stations[@route.stations.index(@station) - 1].name
  end
end