print "Введите a: "
a = gets.chomp.to_f
print "Введите b: "
b = gets.chomp.to_f
print "Введите c: "
c = gets.chomp.to_f

d = (b**2) - 4*(a*c)

if d < 0
  puts "D = #{d}. Корней нет."
elsif d == 0
  x1x2 = -b/2*a
  puts "D = 0, X1 = X2 = #{x1x2}"
else
  sqrt_d = Math.sqrt(d)
  x1 = (-b + sqrt_d) / (2*a)
  x2 = (-b - sqrt_d) / (2*a)
  puts "D = #{d}, X1 = #{x1}, X2 = #{x2}"
end
