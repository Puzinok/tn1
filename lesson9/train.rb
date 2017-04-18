require_relative 'vendor'
require_relative 'validation'

class Train
  include Vendor
  include Validation

  ID_FORMAT = /^[a-z\d]{3}-?[a-z\d]{2}$/i

  attr_reader :id, :speed, :route, :carriages
  
  @@all_trains = {}

  def self.find(train_id)
    @@all_trains[train_id]
  end

  def initialize(id)
    @speed = 0
    @id = id
    validate!
    is_uniq?
    @carriages = []
    @@all_trains[@id] = self
  end

  def each_carriage
    carriages.each { |car| yield(car) }
  end

  def add_carriage(carriage)
    return if @carriages.include?(carriage)
    @carriages << carriage if valid_carriage?(carriage) && stopped?
  end

  def delete_carriage(carriage)
    @carriages.delete(carriage) if stopped?
  end

  def stop
    self.speed = 0
  end

  def stopped?
    speed.zero?
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

  attr_writer :speed

  def valid_carriage?; end

  def is_uniq?
    raise 'Поезд с таким номером уже сушествует!' if Train.find(id)
    true
  end

  def motion(direction)
    current_station.departure(self)
    shift = direction == :forward ? 1 : -1
    @station_index += shift
    current_station.arrive(self)
  end
end
