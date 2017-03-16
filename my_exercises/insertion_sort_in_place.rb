# insertion sort

# high-level view of insertion sort in place:
# - define a position `n`, initially 0
# - the first `n` elements of the array are sorted
# - sort from left to right, incrementing `n`,
# and preserving that property


# sort given array
def sort(array)
  for index in (0...array.size)
    order_insert(array[index], array, index)
  end
  array
end

p sort([10, 5, 3, 0]) # [0, 3, 5, 10]
p sort([]) # []
p sort([1, 3, 10, 4]) # [1, 3, 4, 10]
p sort([1, 1, 1, 1, 1]) # [1, 1, 1, 1, 1]
