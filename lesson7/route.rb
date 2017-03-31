class Route
  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    validate!
  end

  def valid?
    validate!
  rescue
    false
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    if station != @stations.last && station != @stations.first
      @stations.delete(station)
    end
  end

  private
  def validate!
    raise "Начальной станции не существует!" if !@stations.first.is_a? Station
    raise "Конечной станции не существует!" if !@stations.last.is_a? Station
    true
  end
end