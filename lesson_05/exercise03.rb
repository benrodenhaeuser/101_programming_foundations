arr1 = ['a', 'b', ['c', ['d', 'e', 'f', 'g']]]
arr2 = [{first: ['a', 'b', 'c'], second: ['d', 'e', 'f']}, {third: ['g', 'h', 'i']}]
arr3 = [['abc'], ['def'], {third: ['ghi']}]
hsh1 = {'a' => ['d', 'e'], 'b' => ['f', 'g'], 'c' => ['h', 'i']}
hsh2 = {first: {'d' => 3}, second: {'e' => 2, 'f' => 1}, third: {'g' => 0}}

p arr1[2][1][3] # 'g'
p arr2[1][:third][0] # 'g'
p arr3[2][:third][0][0] # 'g'
p hsh1['b'][1] # 'g'
p hsh2[:third].keys[0] # 'g'

# alternatively, for the last:
p hsh2[:third].key(0) # 'g'
# Hash#key returns the key for the first occurences of value 0

# Note that these solutions look similar ... but they are not!
# Hash#keys and Hash#key are different methods! 
