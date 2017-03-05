# mortgage_payment_calculator.rb

def calc_monthly_payment(principal, annual_interest_percent, term_in_years)
  monthly_interest_percent = annual_interest_percent / 12
  monthly_interest_decimal = monthly_interest_percent / 100
  term_in_months = term_in_years * 12
  monthly_payment = principal * (monthly_interest_decimal /
                    (1 - (1 + monthly_interest_decimal)**-term_in_months))
  monthly_payment.round(2)
end

def prompt(message)
  puts "=> #{message}"
end

def valid_i?(number)
  number.to_i.to_s == number
end

def valid_rate?(number)
  (number.to_i.to_s == number || number.to_f.to_s == number) &&
    number.to_f != 0.0
end

def valid_term?(number)
  valid_i?(number) && number.to_i != 0
end

prompt("Welcome to the mortgage payment calculator.")

loop do
  principal = nil
  loop do
    prompt("What is the principal in dollars?")
    principal = gets.chomp
    break if valid_i?(principal)
    prompt("That is not a valid input.")
  end

  annual_interest_percent = nil
  loop do
    prompt("What is the annual interest rate in percent?")
    annual_interest_percent = gets.chomp
    break if valid_rate?(annual_interest_percent)
    prompt("Please enter a non-zero interest rate in percent.")
  end

  term_in_years = nil
  loop do
    prompt("What is the duration of the loan in years?")
    term_in_years = gets.chomp
    break if valid_term?(term_in_years)
    prompt("Please enter a non-zero duration in years.")
  end

  monthly_payment = calc_monthly_payment(
    principal.to_i,
    annual_interest_percent.to_f,
    term_in_years.to_i
  )

  prompt("The monthly payment is #{monthly_payment} USD.")

  prompt("Do you want to make another calculation?")
  answer = gets.chomp
  break unless answer.downcase.start_with?("y")
end

prompt("Good-bye!")
