# calculator with language (German or English) set by the user
# data for language-specific user messages in file "./user_messages.json"

# create output for user
require 'json'
json_file = File.read('./user_messages.json')
MSGS = JSON.parse(json_file)

def prompt(message)
  puts "=> #{message}"
end

def message(message_key)
  if !defined?(LANGUAGE)
    MSGS['bilingual'][message_key]
  else
    MSGS[LANGUAGE][message_key]
  end
end

def to_message(operation)
  result = case operation
           when 'add'      then message('adding')
           when 'subtract' then message('subtracting')
           when 'multiply' then message('multiplying')
           when 'divide'   then message('dividing')
           end
  result
end

# validate input from user
def valid_language?(language)
  %w(de en).include?(language)
end

def valid_name?(name)
  !name.empty?
end

def valid_number?(number)
  number.to_i.to_s == number
end

def valid_operation?(operation)
  %w(add subtract multiply divide).include?(operation)
end

# calculation engine
def calculate(number1, number2, operation)
  result = case operation
           when 'add'      then number1 + number2
           when 'subtract' then number1 - number2
           when 'multiply' then number1 * number2
           when 'divide'   then number1.to_f / number2.to_f
           end
  result
end

# main: language and user name
prompt(message('welcome'))
loop do
  input = gets.chomp
  if valid_language?(input.downcase)
    LANGUAGE = input.downcase
    break
  else
    prompt(message('invalid_language_warning'))
  end
end

name = ''
prompt(message('please_enter_name'))
loop do
  name = gets.chomp
  break if valid_name?(name)
  prompt(message('invalid_name_warning'))
end

prompt(message('hi') + name)

# main: calculations
loop do
  number1 = nil
  loop do
    prompt(message('please_enter_number'))
    number1 = gets.chomp
    break if valid_number?(number1)
    prompt(message('invalid_number_warning'))
  end

  number2 = nil
  loop do
    prompt(message('please_enter_number'))
    number2 = gets.chomp
    break if valid_number?(number2)
    prompt(message('invalid_number_warning'))
  end

  prompt(message('please_enter_operation'))

  operation = nil
  loop do
    operation = gets.chomp
    break if valid_operation?(operation)
    prompt(message('invalid_operation_warning'))
  end

  prompt(
    to_message(operation, number1, number2) <<
    message('the_two_numbers') <<
    "#{number1}#{message('and')}#{number2}"
  )

  prompt(
    message('the_result_is') <<
    calculate(number1.to_i, number2.to_i, operation).to_s
  )

  prompt(message('repeat?'))
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt(message('goodbye'))
