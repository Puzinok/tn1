require_relative 'vendor'

class Train
  include Vendor

  attr_reader :id, :speed, :route, :carriages
  
  @@all_trains = {}

  def self.find(train_id)
    @@all_trains[train_id]
  end

  ID_FORMAT = /^[a-z\d]{3}-?[a-z\d]{2}$/i
  
  def initialize(id)
    @speed = 0
    @id = id
    validate!
    @carriages = []
    @@all_trains[@id] = self
  end


  def valid?
    validate!
  rescue
    false
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

  def validate!
    raise "Номер не соответствует формату!" if id.to_s !~ ID_FORMAT
    raise "Поезд с таким номером уже сушествует!" if Train.find(id)
    true
  end
  
  #метод для перемещения поезда, используется только внутри
  def motion(direction)
    current_station.departure(self)
    shift = direction == :forward ? 1 : -1
    @station_index += shift
    current_station.arrive(self)
  end

end