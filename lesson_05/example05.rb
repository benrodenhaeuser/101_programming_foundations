[[1, 2], [3, 4]].map do |arr|
  arr.map do |num|
    num * 2
  end
end

# What will be printed?
Nothing

# What will be returned?
[[2, 4], [6, 8]]

# What are the relevant actions to distinguish?

# 1. Method call to `map` on line 1
# 2. Block execution on line 1 to 5
# 3. Method call to `map` on line 2 ("inner method call")
# 4. Inner block execution on line 2 to 4 ("inner block execution")
# 5. call to * on line 3

# By action breakdown of what happens in detail:

# 1.

- action: Method call to map (outer map call)
- how often is action taken? once
- line: 1
- object: [[1, 2], [3, 4]]
- side effect: no side effect
- return value: new array: [[2, 4], [6, 8]]
- return value used? no

# 2.

- action: Block execution (outer block execution)
- how often is action taken? twice
- line: 1-5
- object: each inner array, i.e., [1, 2] and [3, 4]
- side effect: no side effect
- return value: [2,4] (first iteration) [6, 8] (second iteration) (a new array)
- return value used? yes, to determine return value of outer map call

# 3.

- action: Method call to map (inner map call)
- how often is action taken? twice
- line: 2
- object: each inner array, i.e., [1, 2] and [3, 4]
- side effect: no side effect
- return value: [2, 4] (first call), [6, 8] (second call) (a new array)
- return value used? yes, to determine return value of outer block.

# 4.

- action: Block execution (inner block execution)
- how often is action taken? four times
- line: 2-4
- object: (each) element of (each) subarray, i.e., 1, 2, 3, 4
- side effect: no side effect
- return value: 2 (first execution), 4 (second execution), 6 (third execution), 8 (fourth execution) (an integer)
- return value used? yes, to determine return value of inner map call

# 5.

- action: Call to *
- how often is action taken? four times
- line: 3
- object: (each) element of (each) subarray, i.e., 1, 2, 3, 4, passing 2 as argument
- side effect: no side effect
- return value: doubled value of calling object, i.e., 2, 4, 6, 8 (an integer)
- return value used? yes, to determine return value of inner block
