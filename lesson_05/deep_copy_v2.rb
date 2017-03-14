# deep_copy produces a deep copy of its input
#
# Valid inputs are arbitrarily nested arrays and hashes of strings,
# integers, floats and symbols
#
# Note one limitation:
# hash keys are required to be immutable, i.e., symbols, floats or integers

def immutable?(obj)
  obj.instance_of?(Symbol) ||
    obj.instance_of?(Float) ||
    obj.instance_of?(Integer)
end

def string?(obj)
  obj.instance_of?(String)
end

def array?(obj)
  obj.instance_of?(Array)
end

def legal_hash?(obj)
  obj.instance_of?(Hash) &&
    obj.keys.all? { |key| immutable?(key) }
end

def deep_copy(obj)
  if immutable?(obj)
    obj_copy = obj
  elsif string?(obj)
    obj_copy = obj.clone
  elsif array?(obj)
    obj_copy = Array.new
    obj.each { |value| obj_copy << deep_copy(value) }
  elsif legal_hash?(obj)
    obj_copy = Hash.new
    obj.each { |key, value| obj_copy[key] = deep_copy(value) }

  else
    puts "#{obj} cannot be copied!"
  end

  obj_copy
end

# tests

def different_ids?(obj, obj_copy)
  diff_objs = true
  unless immutable?(obj)
    diff_objs = obj.object_id != obj_copy.object_id
  end

  diff_array_vals = true
  if array?(obj)
    diff_array_vals = (0...obj.size).all? do |index|
      different_ids?(obj[index], obj_copy[index])
    end
  end

  diff_hash_vals = true
  if legal_hash?(obj)
    diff_hash_vals = obj.keys.all? do |key|
      different_ids?(obj[key], obj_copy[key])
    end
  end

  diff_objs && diff_array_vals && diff_hash_vals
end

def the_same?(obj, obj_copy)
  obj.to_s == obj_copy.to_s
end

arr = ['a', ['b', 'c'], ['d', ['e', ['f', 'g']]]]
arr_copy = deep_copy(arr)
p the_same?(arr, arr_copy) # true
p different_ids?(arr, arr_copy) # true

puts

arr2 = [1, { two: "val", three: "val" }, ["s1", ["s3"]], [1.3, 2.4, 3.2]]
arr2_copy = deep_copy(arr2)
p the_same?(arr2, arr2_copy) # true
p different_ids?(arr2, arr2_copy) # true

puts

hash = { key: ['a', { :b => 'c' }, ['d', ['e', ['f', 'g']]]] }
hash_copy = deep_copy(hash)
p the_same?(hash, hash_copy) # true
p different_ids?(hash, hash_copy) # true

puts

hash2 = { ['a', ['b', 'c'], ['d', ['e', ['f', 'g']]]] => 'v' }
hash2_copy = deep_copy(hash2) # invalid input warning
p the_same?(hash2, hash2_copy) # false
p different_ids?(hash2, hash2_copy) # true
