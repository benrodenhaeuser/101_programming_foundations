def factors_with_do(number)
  dividend = number
  divisors = []
  loop do
    break if dividend <= 0
    divisors << number / dividend if number % dividend == 0
    dividend -= 1
  end
  divisors
end

p factors(-10)

# another option would be to use a while loop (one line shorter!):
def factors_with_do(number)
  dividend = number
  divisors = []
  while dividend > 0
    divisors << number / dividend if number % dividend == 0
    dividend -= 1
  end
  divisors
end
