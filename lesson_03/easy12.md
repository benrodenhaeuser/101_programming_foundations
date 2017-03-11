`!` is used for negation (of Boolean values). For example:

  value = 0
  if value != 1
    puts "not equal to 1" # => "not equal to 1"
  end

`?` is the symbol for the ternary operator. For example:

  true ? puts "true" : puts "false" # => true

This is equivalent to

  if true
    puts "true"
  else
    puts "false"
  end

As for the scenarios:

1. The `!=` operator expresses inequality of the Boolean equivalents of its two arguments.
2. `!user_name` turns `user_name` into the negation of the Boolean equivalent of `user_name`.
3. Methods that end with a bang usually mutate the caller. This is, however, just a convention, i.e., it's not part of Ruby syntax.
4. "Put `?` before   something": see description of ternary operator above.
5. Putting `?` at the end of a method name indicates that the method is expected to return a truth value. Again, this is not Ruby syntax, but a convention.
6. Putting `!!` before an expression converts the expression to its Boolean equivalent.
