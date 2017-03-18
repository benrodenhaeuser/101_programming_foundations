arr = [[1, 6, 7], [1, 4, 9], [1, 8, 3]]

sorted = arr.sort_by do |subarray|
  subarray.select do |number|
    number.odd?
  end
end

p sorted
