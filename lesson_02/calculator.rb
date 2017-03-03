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

puts "Please enter the operation you want to perform"
puts "(type 'add', 'subtract', 'multiply' or 'divide')"
operation = gets.chomp

puts calculate(number1, number2, operation)
