class PassengerTrain < Train
  validate :id, :format, ID_FORMAT
  def valid_carriage?(carriage)
    carriage.instance_of? PassengerCarriage
  end
end
