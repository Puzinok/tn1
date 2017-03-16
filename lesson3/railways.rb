class Station

  attr_reader :name, :trains

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

  def trains_by_type(type)
    @type = []
    @trains.each do |t|
      @type << t if t.type == type
    end
  end

end

class Route
  attr_reader :stations

  def initialize(first_st, last_st)
    @stations = [first_st, last_st]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    if station != @stations.last && station != @stations.first
      @stations.delete(station)
    end
  end

end


class Train
  attr_reader :speed, :cars, :type, :station

  def initialize(id, type, cars)
    @speed = 0
    @id = id
    @type = type
    @cars = cars.to_i
  end

  def speed_up(num)
    @speed += num.abs
  end

  def brake
    @speed = 0
  end

  def add_car
    @cars += 1 if @speed == 0 
  end 

  def delete_car
    @cars -= 1 if @speed == 0 && @cars >= 0
  end
  

  def add_route(route)
    @route = route
    @current = 0
    @station = @route.stations[@current]
    @station.arrive(self)
  end

  def motion(direction)
    @station.departure(self)
    if direction == "forward"
      @station = @route.stations[@current += 1]
    else
      @station = @route.stations[@current -= 1]
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
    @station
  end

  def next_st
    @route.stations[@current + 1] if @station != @route.stations.last
  end

  def prev_st
    @route.stations[@current - 1] if @station != @route.stations.first
  end
end