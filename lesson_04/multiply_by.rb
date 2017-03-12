def multiply_by(numbers, multiplier)
  multiplied_numbers = []
  index = 0

  loop do
    break if index == numbers.size

    multiplied_numbers.push(numbers[index] * multiplier)

    index += 1
  end

  multiplied_numbers
end

ary = [0, 1, 2, 3, 4, 5, 6]
p multiply_by(ary, 10)
