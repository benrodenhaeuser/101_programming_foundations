require 'json'
config = File.read('./rock_paper_lizard_config.json')
MESSAGES = JSON.parse(config)

VALID_INPUTS = %w(r p sc l sp)
VALID_CHOICES = %w(rock paper scissors lizard spock)
WIN_PAIRS = [
  ["rock", "lizard"], ["lizard", "spock"],
  ["scissors", "lizard"], ["paper", "spock"],
  ["spock", "rock"], ["spock", "scissors"],
  ["rock", "scissors"], ["paper", "rock"],
  ["lizard", "paper"], ["scissors", "paper"]
]

def prompt(message_key, subst = {})
  message = MESSAGES[message_key] % subst
  puts "=> #{message}"
end

def request_choice
  your_input = nil
  loop do
    prompt('choose!')
    your_input = gets.chomp
    if your_input.start_with?('q')
      prompt('bye')
      exit
    elsif VALID_INPUTS.include?(your_input)
      break
    end
    prompt('invalid_input')
  end

  VALID_CHOICES.each do |choice|
    return choice if choice.start_with?(your_input)
  end
end

def display_choices(choices)
  prompt(
    'choices_made_were',
    {
      your_choice: choices[:your_choice],
      comp_choice: choices[:comp_choice]
    }
  )
end

def evaluate_round(choices)
  if WIN_PAIRS.include?([choices[:your_choice], choices[:comp_choice]])
    'you_won_round'
  elsif WIN_PAIRS.include?([choices[:comp_choice], choices[:your_choice]])
    'you_lost_round'
  else
    'a_tie'
  end
end

def update_score(score, round_winner)
  if round_winner == 'you_won_round'
    score[:your_score] += 1
  elsif round_winner == 'you_lost_round'
    score[:computer_score] += 1
  end
end

def display_score(score)
  prompt(
    'current_score_is',
    {
      your_score: score[:your_score],
      computer_score: score[:computer_score]
    }
  )
end

def game_winner?(score)
  score[:your_score] == 5 || score[:computer_score] == 5
end

def display_game_winner(score)
  prompt("you_lost_game") if score[:computer_score] == 5
  prompt("you_won_game") if score[:your_score] == 5
end

def request_rematch
  answer = nil
  loop do
    prompt('again?')
    answer = gets.chomp
    break if answer.downcase.start_with?('q', 'c')
    prompt("invalid_input")
  end
  answer
end

prompt('welcome')
prompt('how_to_exit')

loop do
  score = {
    your_score: 0,
    computer_score: 0
  }

  loop do
    choices = {
      your_choice: request_choice(),
      comp_choice: VALID_CHOICES.sample()
    }

    display_choices(choices)
    round_winner = evaluate_round(choices)
    prompt(round_winner)
    update_score(score, round_winner)
    display_score(score)
    if game_winner?(score)
      display_game_winner(score)
      break
    end
  end

  answer = request_rematch()
  break unless answer.downcase.start_with?('c')
end
