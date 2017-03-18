a = 2
b = [5, 8]
arr = [a, b]

arr[0] += 2 # so now a = 4? NO! a is still 2!
arr[1][0] -= a # so now b = [3, 8]

p a # 2
p b # [3, 8]
