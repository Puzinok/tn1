require_relative 'validation'
class Station
  include Validation

  NAME_FORMAT = /\w.+/i
  
  attr_reader :name, :trains

  validate :name, :presence
  validate :name, :format, NAME_FORMAT

  def self.all
    @@all_stations ||= []
  end

  def initialize(name)
    @trains = []
    @name = name
    validate!
    is_uniq?
    @@all_stations << self
  end

  def each_train
    trains.each { |train| yield(train) }
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

  def is_uniq?
    raise 'Такая станция уже есть!' if self.class.all.find { |s| s.name == name }
    true
  end
end
