# deep_copy makes a deep copy of an input formed
# according to these rules:
# - empty arrays are valid inputs.
# - strings are valid inputs.
# - arrays of strings are valid inputs.
# - if we have a list of valid inputs,
#   then collecting them in an array gives us a valid input.

def deep_copy(obj)
  copy_of_obj = obj.clone
  if copy_of_obj.instance_of?(Array)
    copy_of_obj.each_with_index do |inner_obj, index|
      copy_of_obj[index] = deep_copy(inner_obj)
    end
  end
  copy_of_obj
end

def id_test(obj, obj_copy)
  puts "obj: #{obj}"
  puts "obj_copy: #{obj_copy}."
  if obj.object_id != obj_copy.object_id
    puts "They do not have the same id."
  else
    puts "WARNING: They have the same id."
  end
  puts

  if obj.instance_of?(Array)
    obj.each_index do |index|
      id_test(obj[index], obj_copy[index])
    end
  end
end

def mutation_test(obj, obj_copy)
  if obj.instance_of?(String)
    obj_copy << " MUTATED"
    puts "original string:             #{obj}"
    puts "copied and mutated string:   #{obj_copy}"
  else
    obj.each_index do |index|
      mutation_test(obj[index], obj_copy[index])
    end
  end
end

arr = ['a', ['b', 'c'], ['d', ['e', ['f', 'g']]]]
arr_copy = deep_copy(arr)
puts ">>>> ID TEST"
puts
id_test(arr, arr_copy)
puts
puts ">>>> MUTATION TEST"
puts
mutation_test(arr, arr_copy)
