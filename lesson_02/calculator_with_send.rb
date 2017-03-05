# Just playing around here to test the 'send' method.

# The idea of this refactored program is to avoid the use of a conditional
# With the send method, we can send methods to objects. In this case, we are
# sending to the "global object" (I suppose?)

def addition(number1, number2)
  number1 + number2
end

def subtraction(number1, number2)
  number1 - number2
end

def multiplication(number1, number2)
  number1 * number2
end

def division(number1, number2)
  number1.to_f / number2.to_f
end

puts 'Welcome! Please enter the operation you want to perform.'
puts "(type 'addition', 'subtraction', 'multiplication' or 'division')"
operation = gets.chomp
puts 'Please enter the first number argument.'
number1 = gets.chomp.to_i
puts 'Please enter the second number argument.'
number2 = gets.chomp.to_i

puts(send(operation, number1, number2))
