feb = [0,1]
loop do
  feb_next = feb[-1] + feb[-2]
  break if  feb_next > 100 
  feb << feb_next
end






