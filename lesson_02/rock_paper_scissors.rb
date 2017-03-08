require 'json'
config = File.read('./rock_paper_scissors_config.json')
MESSAGES = JSON.parse(config)
VALID_CHOICES = %w(rock paper scissors)

def prompt(message_key, subst = {})
  message = MESSAGES[message_key] % subst
  puts "=> #{message}"
end

def win?(player1, player2)
  (player1 == 'rock' && player2 == 'scissors') ||
    (player1 == 'paper' && player2 == 'rock') ||
    (player1 == 'scissors' && player2 == 'paper')
end

def compute_result(human, computer)
  if win?(human, computer)
    'you_won'
  elsif win?(computer, human)
    'you_lost'
  else
    'a_tie'
  end
end

prompt('welcome')

loop do
  your_choice = 'nil'
  loop do
    prompt('choose!')
    your_choice = gets.chomp
    break if VALID_CHOICES.include?(your_choice)
    prompt('invalid_choice')
  end

  comp_choice = VALID_CHOICES.sample
  prompt(
    'choices_made_were',
    { your_choice: your_choice, comp_choice: comp_choice }
  )
  prompt(compute_result(your_choice, comp_choice))

  prompt('again?')
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end
