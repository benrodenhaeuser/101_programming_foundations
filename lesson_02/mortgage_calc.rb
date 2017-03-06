# multilingual mortgage_payment_calculator_v_2.rb

# user prompts
require 'json'
config_data = File.read("./mortgage_calc_config.json")
LANGUAGES = JSON.parse(config_data)

def prompt(message_key, subst = {})
  if !defined?(LANGUAGE)
    message = ""
    LANGUAGES.each do |_, language|
      message << language[message_key] + " "
    end
  else
    message = LANGUAGES[LANGUAGE][message_key] % subst
  end
  puts "=> #{message}"
end

# input validation
def valid_language?(language)
  LANGUAGES.keys.include?(language)
end

def valid_int?(number)
  number.to_i.to_s == number
end

def valid_float?(number)
  valid_int?(number) || number.to_f.to_s == number
end

def valid_principal?(number)
  valid_int?(number) && number.to_i >= 0
end

def valid_rate?(number)
  valid_float?(number) && number.to_f > 0
end

def valid_term?(number)
  valid_int?(number) && number.to_i > 0
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

# user interaction
prompt("welcome")
loop do
  prompt("language?")
  lang = gets.chomp
  if valid_language?(lang.downcase)
    LANGUAGE = lang.downcase
    break
  end
end

loop do
  principal = nil
  loop do
    prompt("principal?")
    principal = gets.chomp
    break if valid_principal?(principal)
    prompt("invalid_principal")
  end

  annual_interest_percent = nil
  loop do
    prompt("interest_rate?")
    annual_interest_percent = gets.chomp
    break if valid_rate?(annual_interest_percent)
    prompt("invalid_interest_rate")
  end

  term_in_years = nil
  loop do
    prompt("term?")
    term_in_years = gets.chomp
    break if valid_term?(term_in_years)
    prompt("invalid_term")
  end

  prompt('calculating_based_on')
  prompt('principal', { principal: principal })
  prompt('rate', { rate: annual_interest_percent })
  prompt('term', { term: term_in_years })

  monthly_payment = calc_monthly_payment(
    principal.to_i,
    annual_interest_percent.to_f,
    term_in_years.to_i
  )

  prompt('your_monthly_payment', { monthly_payment: monthly_payment })

  prompt("again?")
  answer = gets.chomp
  break unless answer.downcase.start_with?(LANGUAGES[LANGUAGE]['yes'])
end

prompt("bye")
