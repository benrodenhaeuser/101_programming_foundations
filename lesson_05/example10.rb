[[[1, 2], [3, 4]], [5, 6]].map do |arr|
  arr.map do |el|
    if el.to_s.size == 1    # it's an integer
      el + 1
    else                    # it's an array
      el.map do |n|
        n + 1
      end
    end
  end
end

# Launch School note: if you find that you need to be doing this, then probably there is something wrong with your design

# first guess:
# [2, 3, 4, 5, 6, 7] ?
# second guess:
# the conditional is executed 6 times, and returns 2, 3, 4, 5, 6, 7 in turn NOT TRUE!

# relevant actions:

1. call to map on line 1
2. block execution on line 1 to 11
3. call to map on line 2
4. block execution on line 2 to 10
5. conditional on line 3 to 9 (with additional actions inside)

# 1.

action: call to map
how many times? once
line: 1
object: [[[1, 2], [3, 4]], [5, 6]]
return value: [[[2, 3], [4, 5]], [6, 7]]
return value used: no

# 2.

action: block execution
how many times? twice (each element of array)
line: starting line 2
object: [[1, 2], [3, 4]] and [5, 6], in turn
return value: [[2, 3], [4, 5]] and [6, 7]
return value used: to determine

# 3.

action: call to map
line: twice (bc that is how often the containing block runs)
object: [[1, 2], [3, 4]] and [5, 6], in turn
return value: [[2, 3], [4, 5]] and [6, 7]
return value used: to determine return value of block

# 4.

action: block execution
how many times? four times (on the elements of each map-caller)
line: starting line 2
object: [1,2] and [3,4] and 5 and 6
return value: [2, 3] and [4, 5] and 6 and 7
return value used:

# 5.

action: conditional
how many times? called 4 times
line:
object: [1,2] and [3,4] and 5 and 6
return value: [2, 3] and [4, 5] and 6 and 7
return value used:
