my_arr = [[18, 7], [3, 12]].each do |arr|
  arr.each do |num|
    if num > 5
      puts num
    end
  end
end

# What will be printed?
18
7
12

# What will be returned overall?
[[18, 7], [3, 12]]

# What are the relevant actions to distinguish?

# 1. assignment on line 1
# 2. method call to each on line 1
# 3. block execution line 1 to 7
# 4. method call to each on line 2
# 5. inner block execution  line 2 to 6
# 6. conditional line 3 to 5
# 7. comparison statement on line 3 (?)
# 8. call to puts on line 4


# By action breakdown of what happens in detail:

# 1.

- action: assignment
- line: line 1
- object: variable `my_arr` # CORRECT: n/a
- side effect: no side effect # CORRECT
- return value: array (i.e., `self`) # CORRECT
- return value used? assigned to variable `my_arr` # CORRECT

# 2.

- action: call to `each` method
- line: 1
- object: array `[[18, 7], [3, 12]]` (containing two inner arrays) #CORRECT
- side effect: no side effect # CORRECT
- return value: that array # CORRECT
- return value used? assigned to variable `my_arr` # CORRECT

# 3.

- action: block execution
- line: 1 to 7
- object: each inner array # CORRECT
- side effect: no side effect # CORRECT
- return value: each inner array # CORRECT
- return value used? not used # CORRECT

# 4.

- action: (inner) call to each `method`
- line: 2
- object: each inner array # I think this is correct.
- side effect: no side effect # CORRECT
- return value: self, i.e., each inner array # CORRECT
- return value used? not used # WRONG: this is used to determine the return value of the outer block

# 5.

- action: (inner) block execution
- line: 2 to 6
- object: each element of (each) inner array # CORRECT
- side effect: no side effect # CORRECT
- return value: 'nil' # CORRECT
- return value used? not used # CORRECT

# 6.

- action: conditional execution
- line: 3 - 5
- object: each element of (each) inner array # CORRECT
- side effect: no side effect # CORRECT
- return value: `nil` (in every iteration!) # CORRECT
- return value used? yes, as return value of block # more precisely: of INNER block

# 7. (not contained in Launch School solution, but I think it should be there!)

- action: comparion statement
- line: 3
- object: each element of each inner array
- side effect: no side effect
- return value: Boolean
- return value used? yes, by conditional

# 8.

- action: call to `puts`
- line: 4
- object: each element of each inner array # CORRECT
- side effect: prints object value to screen # CORRECT
- return value: `nil` # CORRECT
- return value used? yes, by conditional in case `if` condition true # I *think* that's correct
