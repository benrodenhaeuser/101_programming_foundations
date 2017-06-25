def my_method(arg1, arg2)
  arg1 + arg2
end

p my_method(1, 3) # => 4
p my_method('a', 'b') # => 'ab'

def my_other_method(arg)
  puts arg
end

my_other_method(4) # => 4
my_other_method('launch school') # => 'launch school'
