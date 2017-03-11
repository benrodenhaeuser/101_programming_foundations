def foo(param = "no")
  "yes"
end

def bar(param = "no")
  param == "no" ? "yes" : "no"
end

# foo # => returns "yes"
bar(foo) # => is the same as bar("yes")
# bar("yes") # => inspect line 6:
# line 6 says to return "yes" if bar was called with "no", and "no" otherwise
# since we are calling with "yes", we get "no" as a return value.

# the code does not output anything.
