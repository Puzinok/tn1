class CargoCarriage
  include Vendor

  def initialize(capacity)
    @capacity = capacity
    @used_capacity = 0
  end

  def use_capacity(num)
    raise "Объем не может быть отрицательным!" if num < 0
    raise "Свободного объема нет!" if free_capacity - num < 0
    @used_capacity += num
  end

  def free_capacity
    @capacity - @used_capacity
  end

  def print_carriage
    "тип: #{self.class}, свободно: #{free_capacity}, занято #{@used_capacity}."
  end
end