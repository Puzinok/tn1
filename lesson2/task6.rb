cart = {}

loop do 
  puts "Введите название товара: "
  name = gets.chomp
  break if name == "стоп"
  puts "Введите цену товара: "
  price = gets.chomp.to_f
  puts "Введите количество товара: "
  quantity = gets.chomp.to_f

  if cart[name.to_sym].nil?
    cart[name.to_sym] = {price: price, quant: quantity}
  else
    i = 0
    cart[(name + "#{i+=1}").to_sym] = {price: price, quant: quantity}
  end
end

total = 0
cart.each do |k, v|
  puts "#{k}: #{v[:quant]} шт. #{v[:price]} руб."
  sum = v[:quant] * v[:price] 
  puts "Сумма: #{sum} руб."
  total += sum
end
puts "Итого: #{total}"