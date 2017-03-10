vowels = %w( a e i o u y )
vow_index = {}

("a".."z").each.with_index(1) do |a, i|
  vow_index[a] = i if vowels.include?(a)
end
puts vow_index