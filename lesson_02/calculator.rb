def calculate(number1, number2, operation)
  case operation
  when "add"      then number1 + number2
  when "subtract" then number1 - number2
  when "multiply" then number1 * number2
  when "divide"   then number1.to_f / number2.to_f
  else "I don't know this operation"
  end
end

puts "Please enter a number"
number1 = gets.chomp.to_i
puts "Please enter another number"
number2 = gets.chomp.to_i

# note: if the user provides an invalid number, part of the input might be ignored
# or `to_i` might return 0. examples to illustrate:
# "15ruby".to_i # => 15
# "text".to_i # => 0

puts "Please enter the operation you want to perform"
puts "(type 'add', 'subtract', 'multiply' or 'divide')"
operation = gets.chomp

puts calculate(number1, number2, operation)
