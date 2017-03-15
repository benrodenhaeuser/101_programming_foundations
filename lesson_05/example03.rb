[[1, 2], [3, 4]].map do |arr|
  puts arr.first
  arr.first
end

# What will be printed?
1
3

# What will be returned?
# => [1, 3]

# What are the relevant actions to distinguish?

# 1. method call map
# 2. block execution
# 3. call to first on line 3
# 4. call to puts on line 3
# 5. call to first on line 4


# By action breakdown of what happens in detail:

# 1.

- action: call to `map`
- line: 1
- object: array [[1, 2], [3, 4]]
- side effect: no side effect
- return value: new array [1, 3]
- return value used? no

# 2.

- action: block execution
- line: 1 to 4
- object: inner arrays (elements of outer array)
- side effect: no side effect
- return value: first element of inner array
- return value used? used by `map` to build its return value

# 3.

- action: call to `puts`
- line: 2
- object: first element of (each) inner array
- side effect: prints integer to standard output
- return value: nil
- return value used? no

# 4.

- action: call to first
- line: 2
- object: each inner array
- side effect: no side effect
- return value: 0-indexed element of inner array
- return value used? used by `puts`

# 5.

- action: call to first
- line: 3
- object: each inner array
- side effect: no side effect
- return value: 0-indexed element of inner array
- return value used? used as return value of block
