# mortgage_payment_calculator.rb

# prompts
require 'json'
config_data = File.read("./mortgage_payment_calculator_config.json")
MESSAGES = JSON.parse(config_data)

def prompt(message)
  puts "=> #{message}"
end

def message(message_key)
  if !defined?(LANGUAGE)
    MESSAGES['bilingual'][message_key]
  else
    MESSAGES[LANGUAGE][message_key]
  end
end

# validation
def valid_language?(language)
  %w(de en).include?(language)
end

def valid_pos_int?(number)
  number.to_i.to_s == number && number.to_i > 0
end

def valid_non_neg_int?(number)
  number.to_i.to_s == number && number.to_i >= 0
end

def valid_rate?(number)
  (number.to_i.to_s == number || number.to_f.to_s == number) &&
    number.to_f > 0.0
end

# calculation engine
def calc_monthly_payment(principal, annual_interest_percent, term_in_years)
  monthly_interest_percent = annual_interest_percent / 12
  monthly_interest_decimal = monthly_interest_percent / 100
  term_in_months = term_in_years * 12
  monthly_payment = principal * (monthly_interest_decimal /
                    (1 - (1 + monthly_interest_decimal)**-term_in_months))
  monthly_payment.round(2)
end

# main
prompt(message("language?"))
loop do
  lang = gets.chomp
  if valid_language?(lang.downcase!)
    LANGUAGE = lang
    break
  else
    prompt(message('invalid_language'))
  end
end

loop do
  principal = nil
  loop do
    prompt(message("principal?"))
    principal = gets.chomp
    break if valid_non_neg_int?(principal)
    prompt(message("invalid_principal"))
  end

  annual_interest_percent = nil
  loop do
    prompt(message("interest_rate?"))
    annual_interest_percent = gets.chomp
    break if valid_rate?(annual_interest_percent)
    prompt(message("invalid_interest_rate"))
  end

  term_in_years = nil
  loop do
    prompt(message("term?"))
    term_in_years = gets.chomp
    break if valid_pos_int?(term_in_years)
    prompt(message("invalid_term"))
  end

  monthly_payment = calc_monthly_payment(
    principal.to_i,
    annual_interest_percent.to_f,
    term_in_years.to_i
  )

  prompt(
    message("monthly_payment") +
    " #{monthly_payment} " +
    message("currency")
  )

  prompt(message("again?"))
  answer = gets.chomp
  break unless answer.downcase.start_with?("y")
end

prompt(message("bye"))
