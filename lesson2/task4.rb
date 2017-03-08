vowels = ["a", "e", "i", "o", "u", "y"]
vow_index = {}
("a".."z").each_with_index do |a, i|
  if vowels.include?(a)
    vow_index[a] = i+=1
  end
end
puts vow_index


