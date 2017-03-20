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