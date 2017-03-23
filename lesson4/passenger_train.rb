class PassengerTrain < Train
  
  def valid_carriage?(carriage)
    carriage.instance_of? PassengerCarriage
  end
end
