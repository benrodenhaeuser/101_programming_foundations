result = ['ant', 'bear', 'cat'].each_with_object({}) do |value, hash|
  hash[value[0]] = value
end

p result

# value[0] is the first character in the string given in the current iteration

# What is the return value of the expression?
# { "a" => "ant", "b" => "bear", "c" => "cat" }
