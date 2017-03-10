vowels = %w( a e i o u y )
vow_index = {}

("a".."z").each_with_index do |a, i|
  vow_index[a] = i+=1 if vowels.include?(a)
end
puts vow_index