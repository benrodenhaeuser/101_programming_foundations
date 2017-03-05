# calculator with localization option

require 'json'
json_file = File.read('./user_messages.json')
MSGS = JSON.parse(json_file)
$lang = 'bilingual' # Rubocop complains about this

# user prompts

def prompt(string)
  puts "=> #{string}"
end

def create_message(message)
  MSGS[$lang][message]
end

def operation_to_message(operation)
  result = nil
  case operation
  when 'add'      then result = create_message('adding')
  when 'subtract' then result = create_message('subtracting')
  when 'multiply' then result = create_message('multiplying')
  when 'divide'   then result = create_message('dividing')
  end
  result
end

# user input validation

def valid_language?(language)
  if %w(de en).include?(language)
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

# calculation engine

def calculate(number1, number2, operation)
  result = nil
  case operation
  when 'add'      then result = number1 + number2
  when 'subtract' then result = number1 - number2
  when 'multiply' then result = number1 * number2
  when 'divide'   then result = number1.to_f / number2.to_f
  end
  result
end

# main

prompt(create_message('welcome'))
loop do
  $lang = gets.chomp
  if valid_language?($lang)
    break
  else
    prompt('invalid_language_warning')
  end
end

name = ''
prompt(create_message('please_enter_name'))
loop do
  name = gets.chomp
  if valid_name?(name)
    break
  else
    prompt(create_message('invalid_name_warning'))
  end
end

prompt(create_message('hi') + name)

loop do
  number1 = nil
  loop do
    prompt(create_message('please_enter_number'))
    number1 = gets.chomp
    break if valid_number?(number1)
    prompt(create_message('invalid_number_warning'))
  end

  number2 = nil
  loop do
    prompt(create_message('please_enter_number'))
    number2 = gets.chomp
    break if valid_number?(number2)
    prompt(create_message('invalid_number_warning'))
  end

  prompt(create_message('please_enter_operation'))

  operation = nil
  loop do
    operation = gets.chomp
    break if valid_operation?(operation)
    prompt(create_message('invalid_operation_warning'))
  end

  prompt(
    operation_to_message(operation).to_s <<
    create_message('the_two_numbers') <<
    "#{number1}#{create_message('and')}#{number2}"
  )
  prompt(
    create_message('the_result_is') <<
    calculate(number1.to_i, number2.to_i, operation).to_s
  )
  prompt(create_message('repeat?'))
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt(create_message('goodbye'))
