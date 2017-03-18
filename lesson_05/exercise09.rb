# sort each sub-array in arr in reverse order 

arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

sorted = arr.map do |subarray|
  subarray.sort { |a, b| b <=> a }
end

p sorted
