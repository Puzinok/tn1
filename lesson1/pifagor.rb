triangle_sides = []

3.times do |i|
  print "Введите #{i+1} сторону: "
  triangle_sides << gets.chomp.to_f
end

triangle_type = triangle_sides.size - triangle_sides.uniq.size
hipo = triangle_sides.sort!.last

if hipo**2 == triangle_sides[0]**2 + triangle_sides[1]**2
  puts "Прямоугольный"
else
  puts "Не прямоугольный"
end

if triangle_type == 1
  puts "Равнобедренный"
elsif triangle_type == 2
  puts "Равносторонний и равнобедренный"
end
