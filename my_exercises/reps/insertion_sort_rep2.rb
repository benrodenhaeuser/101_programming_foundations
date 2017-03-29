# insertion sort: basic idea

# the basic idea is to sort "from left to right", ensuring that successively
# larger chunks of the array are "already sorted"
# initially, the array consisting just of the first element is already sorted
# now let's create a two-element array that is already sorted using the second
# element. the, a three-element array that is already sorted using the third
# element. and so on.

# so we basically have one outer iteration which we can do with each
# and inside, there is a while loop which does the insertion

# insertion sort: implementation

def insertion_sort(array)
  array.each_index do |index|
    stored_value = array[index]
    index_counter = index - 1
    while index_counter >= 0 && array[index_counter] > stored_value
      array[index_counter + 1] = array[index_counter]
      index_counter -= 1
    end
    array[index_counter + 1] = stored_value
  end
  array
end

# this is a little different from what I did in the first rep, but I would say
# it implements the same algorithm

array = []
p insertion_sort(array) # []

array = [10, 7, 4, 3, 11]
p insertion_sort(array) # [3, 4, 7, 10, 11]

array = [10, 7, 10, 4, 3, 11]
p insertion_sort(array) # [3, 4, 7, 10, 10, 11]
