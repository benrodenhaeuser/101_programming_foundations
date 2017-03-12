def double_numbers(numbers)
  counter = 0
  loop do
    break if counter == numbers.size
    numbers[counter] *= 2
    counter += 1
  end
  numbers
end

ary = [0, 1, 2]
double_numbers(ary)
p ary # => [0, 2, 4]
