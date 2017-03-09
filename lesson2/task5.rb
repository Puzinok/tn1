months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

print "День: "
day = gets.chomp.to_i
print "Месяц: "
month = gets.chomp.to_i
print "Год: "
year = gets.chomp.to_i

days = months.slice(0..month-1)
days[-1] = day
total_days = days.reduce(:+)

if (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
  if month > 2
    puts total_days + 1
  else
    puts total_days
  end
else
  puts total_days
end
