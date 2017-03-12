def double_odd_indexed_numbers(numbers)
  doubled_numbers = []
  index = 0

  loop do
    break if index == numbers.size
    if numbers[index].odd?
      doubled_numbers << numbers[index] * 2
    else
      doubled_numbers << numbers[index]
    end
    index += 1
  end

  doubled_numbers
end

ary = [0, 1, 2, 3, 4, 5, 6]
p double_odd_indexed_numbers(ary)
# => [0, 2, 2, 6, 4, 10, 6]
