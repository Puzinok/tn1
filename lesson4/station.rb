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