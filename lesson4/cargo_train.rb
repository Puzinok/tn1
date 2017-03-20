class CargoTrain < Train
  attr_reader :type

  def initialize(id)
    super
    @type = :cargo
  end
end