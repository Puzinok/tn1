a = gets.chomp.to_i
b = gets.chomp.to_i
c = gets.chomp.to_i

d = (b**2) - 4*(a*c)

if d < 0
	puts "D = #{d}. Корней нет"
elsif d == 0
	x1x2 = -b/2*a
	puts "D = 0, X1 = X2 = #{x1x2}"
else
	x1 = (-b + Math.sqrt(d))/ (2*a)
	x2 = (-b - Math.sqrt(d))/ (2*a)
	puts "D = #{d}, X1 = #{x1}, X2 = #{x2}"
end
