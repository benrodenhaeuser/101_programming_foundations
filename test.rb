def my_method(arr)
  p arr.object_id # 70101470686320
end

arr = [0, 1, 2]
p arr.object_id # 70101470686320
my_method(arr)
