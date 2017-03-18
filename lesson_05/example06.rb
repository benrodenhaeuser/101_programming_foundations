[{ a: 'ant', b: 'elephant' }, { c: 'cat' }].select do |hash|
  hash.all? do |key, value|
    value[0] == key.to_s
  end
end
# => [{ :c => "cat" }]

# What will be printed?
Nothing

# What will be returned?
# See above, i.e.,
# [{ :c => "cat" }]

# What are the relevant actions to distinguish?

# 1. Call to `select` (line 1)
# 2. Block execution (1 to 6 )
# 3. Call to `all` (line 2)
# 4. Inner block execution (line 2 to 4)
# 5. Evaluation of Boolean statement (line 3)
# 6. Element reference – call to slice (Array#[]) (line 3)
# 7. Call to `to_s` (line 3)


# By action breakdown of what happens in detail:

# 1.

- action: Call to select
- line: 1
- object: array [{ a: 'ant', b: 'elephant' }, { c: 'cat' }]
- side effect: no
- return value: new (transformed) array
- return value used? no

# 2.

- action: block execution
- line: 1-5
- object: element of array
- side effect: no
- return value: Boolean (false on first iteration, second on true)
- return value used? yes, to determine return value of select

# 3.

- action: call to all
- line: 2
- object: element of array (i.e., a hash)
- side effect: no
- return value: Boolean (false on first iteration, true on second)
- return value used? yes, to determine return value of block

# 4.

- action: inner block execution
- line: 2-4
- object: element of element of array (i.e., a hash entry)
- side effect: no
- return value: Boolean
- return value used? yes, to determine return value of `all`

# 5.

- action: evaluation of `==` statement
- line: 3
- object: called on object on left side, right side as argument
- side effect: no
- return value: Boolean
- return value used? to determine return value of block

# 6.

- action: call to slice
- line: 3
- object: hash entry value
- side effect: no
- return value: first character of hash entry (i.e., a string)
- return value used? yes to determine return value of `==`

# 6.

- action: call to to_s
- line: 3
- object: hash key
- side effect: no
- return value: string object
- return value used? yes, to determine return value of `==`


# Bonus question: What if we were to replace `all?` with `any?`
# Answer: the return value of select would be [{ a: 'ant', b: 'elephant' }, { c: 'cat' }]
# the inner block returns true for some key value pair of both hashes
# hence hash.any? returns true on each iteration. hence both elements of array are included
# in return value of select
