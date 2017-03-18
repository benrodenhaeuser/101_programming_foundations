# sort the following array so that the inner arrays are ordered according to the numeric value of the strings they contain (using `sort`/`sort_by`):

arr = [['1', '8', '11'], ['2', '6', '13'], ['2', '12', '15'], ['1', '8', '9']]

# what we want:
arr_sorted = [['1', '8', '9'], ['1', '8', '11'], ['2', '6', '13'], ['2', '12', '15']]

arr.sort do |a, b|
  a.to_s <=> b.to_s
end

arr_new = []

for index in (0..2)
  arr_new = arr.sort do |a, b|
    a[index].to_i <=> b[index].to_i
 end
 arr_new
end

p arr_new
# => this does yield the desired result in this case, but only because of a peculiarity of arr
# also note that we are sorting three times!

# Now for the correct solution!

# what is important to understand here is that the <=> operator for arrays performs element-wise comparison.
# so all we really need to do is transform the elements to their numeric values:

result = arr.sort_by do |sub_arr|
  sub_arr.map do |num|
    num.to_i
  end
end

p result

# the result is the same as above here, but now the method is also correct ...

# another option would be to use sort:

result = arr.sort do |a, b|
  first = a.map do |num|
    num.to_i
  end
  second = b.map do |num|
    num.to_i
  end
  first <=> second
end

# but this is needlessly complicated, because we are actually doing the same thing twice, which is exactly what we can avoid by using sort_by

p result
