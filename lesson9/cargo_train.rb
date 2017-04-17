class CargoTrain < Train
  def valid_carriage?(carriage)
    carriage.instance_of? CargoCarriage
  end
end
