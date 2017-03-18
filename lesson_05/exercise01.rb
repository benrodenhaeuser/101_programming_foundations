# order arr by descending numerical value

arr = ['10', '11', '9', '7', '8']

sorted = arr.sort_by { |elem| -(elem.to_i) }

p sorted

# Launch School solution:

arr.sort do |a,b|
  b.to_i <=> a.to_i
end
