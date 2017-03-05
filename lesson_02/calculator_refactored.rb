def prompt(message)
  puts "=> #{message}"
end

def valid_number?(number)
  number.to_i.to_s == number
end

def valid_operation?(operation)
  if %w(add subtract multiply divide).include?(operation)
    true
  else
    false
  end
end

def valid_name?(name)
  if name.empty?
    false
  else
    true
  end
end

def operation_to_message(operation)
  case operation
  when 'add'      then 'Adding'
  when 'subtract' then 'Subtracting'
  when 'multiply' then 'Multiplying'
  when 'divide'   then 'Dividing'
  end
end

def calculate(number1, number2, operation)
  case operation
  when 'add'      then number1 + number2
  when 'subtract' then number1 - number2
  when 'multiply' then number1 * number2
  when 'divide'   then number1.to_f / number2.to_f
  end
end

prompt('Welcome to calculator! Please enter your name.')

name = ''
loop do
  name = gets.chomp
  if valid_name?(name)
    break
  else
    prompt('Make sure to enter a valid name.')
  end
end

prompt("Hi, #{name}")

loop do
  number1 = nil
  loop do
    prompt('Please enter a number')
    number1 = gets.chomp
    break if valid_number?(number1)
    prompt('Hmmm ... this is not a valid number. Go again.')
  end

  number2 = nil
  loop do
    prompt('Please enter another number')
    number2 = gets.chomp
    break if valid_number?(number2)
    prompt('Hmmm ... this is not a valid number. Go again.')
  end

  operator_prompt = <<-MSG
    Please enter the operation you want to perform
    Your options:
    - add
    - subtract
    - multiply
    - divide
  MSG
  prompt(operator_prompt)

  operation = nil
  loop do
    operation = gets.chomp
    break if valid_operation?(operation)
    prompt('Hmmm ... this is not a valid operation. Go again.')
  end

  prompt("#{operation_to_message(operation)} the two numbers #{number1} and #{number2}")

  prompt("The result is #{calculate(number1.to_i, number2.to_i, operation)}")
  prompt('Do you want to perform another calulation? (Y to calculate again)')
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt('We enjoyed calculating for you. Good-bye!')
