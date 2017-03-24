arr = ['10', '11', '9', '7', '8']

p arr.sort do |a, b|
  b.to_i <=> a.to_i
end
# ["10", "11", "7", "8", "9"]

p (arr.sort do |a, b|
  b.to_i <=> a.to_i
end)
# ["11", "10", "9", "8", "7"]

p arr.sort do |a, b| end
# ["10", "11", "7", "8", "9"]

result = arr.sort do |a, b|
  b.to_i <=> a.to_i
end

p result

# ["11", "10", "9", "8", "7"]
