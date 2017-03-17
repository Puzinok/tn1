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
    @trains.select{|t| t.type == type}
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
  attr_reader :speed, :cars, :type

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
    @cars -= 1 if @speed == 0 && @cars > 0
  end
  

  def add_route(route)
    @route = route
    @station_index = 0
    @route.stations[@station_index].arrive(self)
  end

  def motion(direction)
    current_station.departure(self)
    shift = direction == :forward ? 1 : -1
    @station_index += shift
    current_station.arrive(self)
  end

  def forward
    motion(:forward) if current_station != @route.stations.last
  end

  def backward
    motion(:back) if current_station != @route.stations.first
  end
  
  def current_station
    @route.stations[@station_index]
  end

  def next_station
    @route.stations[@station_index + 1] if current_station != @route.stations.last
  end

  def prev_station
    @route.stations[@station_index - 1] if current_station != @route.stations.first
  end
end