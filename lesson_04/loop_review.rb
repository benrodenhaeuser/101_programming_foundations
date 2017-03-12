# a loop that iterates 5 times

how_often = 5
counter = 1
loop do
  break if counter > how_often
  puts "Number of iterations: #{how_often}"
  puts "Current iteration: #{counter}"
  counter += 1
end

puts

# or, with one variable:

iterations = 1

loop do
  puts "Number of iterations = #{iterations}"
  iterations += 1
  break if iterations > 5
end

puts

# a while loop that iterates five times

counter = 0

while counter < 5
  puts 'Hello!'
  counter += 1
end

puts

# a while loop that prints five random numbers

counter = 0

while counter < 5
  p rand(0...100)
  counter += 1
end

puts

# count from 1 to 10

count = 1

until count == 11
  puts count
  count += 1
end

puts

# use an until loop to print each number
numbers = [7, 9, 13, 25, 18]
counter = 0

until counter == numbers.size
  puts numbers[counter]
  counter += 1
end

puts

# print out the odd numbers

for i in 1..100
  puts i if i.odd?
end

puts

# greet your friends

friends = ['Sarah', 'John', 'Hannah', 'Dave']

for friend in friends
  puts "Hello, #{friend}"
end

puts

# write a loop that prints a range of numbers and whether the number is odd

def print_the_numbers(range)
  for number in range
    puts "An odd number: #{number}" if number.odd?
    puts "An even number: #{number}" if number.even?
  end
end

print_the_numbers(1..5)

puts

# break out of the loop if number is between 0 and 10
loop do
  number = rand(100)
  puts number
  break if (0..10).include?(number)
  # alternative: break if number.between?(0,10)
end

puts

# run a loop once or zero times based on a condition, print out how many times you looped

process_the_loop = [true, false].sample
if process_the_loop
  loop do
    puts "looping once"
    break
  end
else
  puts "have not looped"
end

puts

# append the user input to numbers

# numbers = []
#
# loop do
#   puts 'Enter any number:'
#   input = gets.chomp.to_i
#   numbers << input
#   break if numbers.size == 5
# end
# puts numbers

# use a loop to remove and print the names. stop once empty

names = ['Sally', 'Joe', 'Lisa', 'Henry']

loop do
  p names.shift
  break if names.empty?
end

puts

# make a five times block stop iterating at current number 2

5.times do |index|
  current = index
  puts current
  break if current == 2
end

puts

# using next, print only even numbers

number = 0

until number == 10
  number += 1
  next if number.odd?
  puts number
end

puts

# break out of the loop if either of the numbers reaches 5

number_a = 0
number_b = 0

loop do
  number_a += rand(2)
  number_b += rand(2)

  if number_a >= 5 || number_b >= 5
    puts "5 reached"
    break
  end
end

# achieve the same, but use `next`

number_a = 0
number_b = 0

loop do
  number_a += rand(2)
  number_b += rand(2)
  next unless number_a >= 5 || number_b >= 5
  puts "5 reached"
  break
end

# use while loop to print "Hello" twice

def greeting
  puts 'Hello'
end

number_of_greetings = 2

while number_of_greetings > 0
  greeting
  number_of_greetings -= 1
end
