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
    return @stations.delete(station) if station != @stations.last && station != @stations.first
    raise 'Нельзя удалить конечную или начальную станцию!'
  end

  private

  def validate!
    raise 'Начальной станции не существует!' unless @stations.first.is_a? Station
    raise 'Конечной станции не существует!' unless @stations.last.is_a? Station
    true
  end
end
