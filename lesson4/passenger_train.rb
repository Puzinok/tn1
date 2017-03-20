class PassengerTrain < Train
  attr_reader :type

  def initialize(id)
    super
    @type = :passenger
  end
end
