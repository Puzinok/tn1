puts "Как вас зовут?"
name = gets.chomp.capitalize
puts "Ваш рост: "
growth = gets.chomp.to_i

if growth - 110 > 0
  puts "#{name}, ваш идельный вес: #{growth - 110} кг"
else
  puts "Ваш вес уже оптимальный"
end