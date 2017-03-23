class Train
  attr_reader :id, :speed, :route, :carriages

  def initialize(id)
    @speed = 0
    @id = id
    @carriages = []
  end

  def add_carriage(carriage)
    unless @carriages.include?(carriage)
      @carriages.push(carriage) if valid_carriage?(carriage) && stopped?
    end
  end 

  def delete_carriage(carriage)
    @carriages.delete(carriage) if stopped?
  end

  def stop
    self.speed = 0
  end
  
  def stopped?
    self.speed.zero?
  end

  def speed_up(num)
    self.speed += num
  end

  def add_route(route)
    @route = route
    @station_index = 0
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
    @route.stations[@station_index + 1]
  end

  def prev_station
    @route.stations[@station_index - 1] if current_station != @route.stations.first
  end

  protected  
  #проверяет тип вагона
  def valid_carriage?; end

  private
  attr_writer :speed 

  #метод для перемещения поезда, используется только внутри
  def motion(direction)
    current_station.departure(self)
    shift = direction == :forward ? 1 : -1
    @station_index += shift
    current_station.arrive(self)
  end

end