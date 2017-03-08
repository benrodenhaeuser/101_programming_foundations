require 'json'
config = File.read('./rock_paper_scissors_config.json')
MESSAGES = JSON.parse(config)
VALID_CHOICES = ['rock', 'paper', 'scissors']

def prompt(message_key, subst = {})
  message = MESSAGES[message_key] % subst
  puts "=> #{message}"
end

def compute_result(player, computer)
  if (player == 'rock'     && computer == 'scissors') ||
     (player == 'paper'    && computer == 'rock') ||
     (player == 'scissors' && computer == 'paper')
    'you_won'
  elsif (player == 'rock' && computer == 'paper') ||
        (player == 'paper' && computer == 'scissors') ||
        (player == 'scissors' && computer == 'rock')
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
