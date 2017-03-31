class PassengerCarriage
  include Vendor
  
  def initialize(seats)
    @seats = seats
    @takened_seats = 0
  end

  def take_seat
    @takened_seats += 1 if free_seats > 0
    raise "Свободных мест нет!" if free_seats <= 0
  end

  def free_seats
    @seats - @takened_seats
  end

  def print_carriage
    "тип: #{self.class}, свободно: #{free_seats}, занято #{@takened_seats}."
  end
end