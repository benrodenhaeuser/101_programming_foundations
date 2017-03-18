# reverse an array using the built-in sort or sort_by method

arr = [0, 1, 2, 3, 4, 5, 6, 7]

# using `sort`:
reversed = arr.sort { |a, b| arr.index(b) <=> arr.index(a) }

# using `sort_by`:
reversed = arr.sort_by { |elem| -arr.index(elem) }


# note the difference between reversing and sorting in descending order

arr = [0, 1, 3, 2, 4]

p reversed = arr.sort_by { |elem| -arr.index(elem) }
p descending = arr.sort_by { |elem| -elem }

# reversed: [4, 2, 3, 1, 0]
# descening: [4, 3, 2, 1, 0]
