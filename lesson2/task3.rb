feb = [ 0, 1 ]
feb << feb[-1] + feb[-2] while feb[-1] + feb[-2] < 100
puts feb