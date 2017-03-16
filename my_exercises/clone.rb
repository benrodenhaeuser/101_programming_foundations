# assignment: two pointers, one array object

arr1 = [0, 1]
arr2 = arr1

arr1[0] = 1

p arr1 #=> [1, 1]
p arr2 #=> [1, 1]

# shallow copy: two pointers, two objects

arr1 = [0, 1]
arr2 = arr1.clone

arr1[0] = 1

p arr1 #=> [1, 1]
p arr2 #=> [0, 1]

# why shallow?

arr1 = ["Hello", "World"]
arr2 = arr1.clone # an alternative would be arr1.dup

arr1[0].upcase!

# ^ upcase! mutates the string object within the array arr1.
# ^ This string object is shared, i.e., both arr1[0] and arr[1] refer
# ^ to that *same* object. This is what "shallow" means: we have two arrays,
# ^ but the objects within the arrays are *not* copied.

p arr1 #=> ["HELLO", "world"]
p arr2 #=> ["HELLO", "world"]
