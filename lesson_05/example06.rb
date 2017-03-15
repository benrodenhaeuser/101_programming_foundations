[{ a: 'ant', b: 'elephant' }, { c: 'cat' }].select do |hash|
  hash.all? do |key, value|
    value[0] == key.to_s
  end
end
# => [{ :c => "cat" }]

# What will be printed?
Nothing

# What will be returned?
# => [{ :c => "cat" }]

# What are the relevant actions to distinguish?

# 1. Call to `select` (line 1)
# 2. Block execution (1 to 6 )
# 3. Call to `all` (line 2)
# 4. Inner block execution (line 2 to 4)
# 5. Evaluation of Boolean statement (line 3)
# 5. Element reference – call to slice (Array#[]) (line 3)
# 6. Call to `to_s` (line 3)


# By action breakdown of what happens in detail:

# 1.

- action:
- line:
- object:
- side effect:
- return value:
- return value used?

# 2.

- action:
- line:
- object:
- side effect:
- return value:
- return value used?

# 3.

- action:
- line:
- object:
- side effect:
- return value:
- return value used?

# 4.

- action:
- line:
- object:
- side effect:
- return value:
- return value used?

# 5.

- action:
- line:
- object:
- side effect:
- return value:
- return value used?

# 6.

- action:
- line:
- object:
- side effect:
- return value:
- return value used?
