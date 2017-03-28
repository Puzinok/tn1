class Station
  attr_reader :name, :trains

  @@all_stations = []
  
  def self.all
    @@all_stations
  end

  def initialize(name)
    @trains = []
    @name = name
    validate!
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
  
  private
  def validate!
    raise "Отсутствует название станции!" if name.empty?
    raise "Название должно быть больше 1 символа" if name.length < 2
    raise "Такая станция уже есть!" if Station.all.find{|s| s.name == name}
    true
  end
end