cart = {}

loop do 
puts "Введите название товара: "
name = gets.chomp
break if name == "стоп"
puts "Введите цену товара: "
price = gets.chomp.to_f
puts "Введите количество товара: "
quantity = gets.chomp.to_f

cart[name.to_sym] = {price => quantity}
end

total = 0
cart.each do |k, v|
  puts "#{k}: "
  v.each do |price, q|
    puts "#{price} - #{q} шт."
    sum = price * q
    puts "Сумма: #{price * q}"
    puts "------------"
    total += sum
  end
end
puts "Общая сумма: #{total}"


