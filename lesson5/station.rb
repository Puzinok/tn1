class Station
  attr_reader :name, :trains

  @@all_stations = []
  
  def self.all
    @@all_stations
  end

  def initialize(name)
    @trains = []
    @name = name
    @@all_stations << self 
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