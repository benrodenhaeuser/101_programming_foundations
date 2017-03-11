def tricky_method(a_string_param, an_array_param)
  return a_string_param.object_id, an_array_param.object_id
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method(my_string, my_array)

my_string_inner_id, my_array_inner_id = tricky_method(my_string, my_array)

p my_string.object_id == my_string_inner_id # true
p my_array.object_id == my_array_inner_id # true
