# implement insertion sort without using any iterators

# sort array
def sort(array)
  sorted = []
  for index in (0...array.size)
    sorted = insert(array[index], sorted)
  end
  sorted
end

# insert value in sorted array, preserving sortedness
def insert(value, sorted)
  return [value] if sorted == []
  # ^ edge case; won't happen if we call from sort
  index = 0
  loop do
    if value <= sorted[index]
      sorted = insert_at(index, value, sorted)
      break
    end
    index += 1
    if index == sorted.size
      sorted[index] = value
      break
    end
  end
  sorted
end

# insert value in array at index
def insert_at(index, value, array)
  return nil if index > array.size
  # ^ edge case; won't happen if we call from insert
  breakpoint = array.size + 1
  value_to_insert = value
  loop do
    value_stored = array[index]
    array[index] = value_to_insert
    value_to_insert = value_stored
    index += 1
    break if index == breakpoint
  end
  array
end

p sort([10, 5, 3, 0]) # [0, 3, 5, 10]
p sort([]) # []
p sort([1, 3, 10, 4]) # [1, 3, 4, 10]
p sort([1, 1, 1, 1, 1]) # [1, 1, 1, 1, 1]
