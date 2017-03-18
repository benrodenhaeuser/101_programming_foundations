# preserving the structure of this array, produce a new one with each numerical value incremented by 1
arr = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]

arr_new = arr.map do |element|
  incremented_as_a = element.to_a.map do |pair|
    [pair[0], pair[1]+1]
  end
  incremented_as_a.to_h
end

p arr_new # [{:a=>2}, {:b=>3, :c=>4}, {:d=>5, :e=>6, :f=>7}]


# Launch School solution:
[{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}].map do |hsh|
  incremented_hash = {}
  hsh.each do |key, value|
    incremented_hash[key] = value + 1
  end
  incremented_hash
end
