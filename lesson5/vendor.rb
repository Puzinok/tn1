module Vendor
  attr_reader :vendor_name
  
  def set_vendor_name
    puts "Введите название производителя:"
    name = gets.chomp
    @vendor_name = name if name.empty? == false
  end
end