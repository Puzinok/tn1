class Station
  attr_reader :name, :trains

  @@all_stations = []

  NAME_FORMAT = /\w.+/i

  def self.all
    @@all_stations
  end

  def initialize(name)
    @trains = []
    @name = name.capitalize!
    validate!
    @@all_stations << self
  end

  def each_train
    trains.each { |train| yield(train) }
  end

  def valid?
    validate!
  rescue
    false
  end

  def arrive(train)
    @trains << train
  end

  def departure(train)
    @trains.delete(train)
  end

  def trains_by_type(type)
    @trains.select { |t| t.type == type }
  end

  private

  def validate!
    raise 'Отсутствует название станции!' if name.to_s.empty?
    raise 'Название должно быть больше 1 символа' if name !~ NAME_FORMAT
    raise 'Такая станция уже есть!' if self.class.all.find { |s| s.name == name }
    true
  end
end
