[[1, 2], [3, 4]].each do |arr|
  puts arr.first
end
# 1
# 3
# => [[1, 2], [3, 4]]


# My explanation:

# We call the each method on an array, passing a block. The array is actually an array consisting of two arrays. I will refer to the top-level array as the outer array, and to the nested arrays as inner arrays. The each method iterates over the elements of outer array. On each iteration, each yields to the block, passing the variable arr. So on each iteration, arr references one of the inner arrays, and the block is executed with that argument. That is why, on each iteration, we print the first element of the current inner array (call to first, call to puts). The return value of action of yielding to the block is actually nil, but the return value is not used by each. This is why 1 and 3 are printed. Each returns the object on which it is called, hence the return value each is the outer array.

# Launch School explanation:

# The Array#each method is being called on the multi-dimensional array [[1, 2], [3, 4]]. Each inner array is passed to the block in turn and assigned to the local variable arr. The Array#first method is called on arr and returns the object at index 0 of the current array - in this case the integers 1 and 3, respectively. The puts method then outputs a string representation of the integer. puts returns nil and, since this is the last evaluated statement within the block, the return value of the block is therefore nil. each doesn't do anything with this returned value though, and since the return value of each is the calling object - in this case the nested array [[1, 2], [3, 4]] - this is what is ultimately returned.


# Questions to ask:

# What is the type of action being performed (method call, block, conditional, etc)?
# What is the object that action is being performed on?
# What is the side-effect of that action, if any?
# What is the return value of that action?
# Is the return value used by whatever instigated the action?

# Suggests a tabular format:

# The columns are: line – action – object – side effect – return value – is return value used?
# The rows describe what happens in sequence, and working from the outside in.
