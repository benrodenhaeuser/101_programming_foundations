require 'yaml'
MESSAGES = YAML.load_file('./rock_paper_lizard_config.yaml')


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
  player_input = nil
  loop do
    prompt('choose!')
    player_input = gets.chomp
    if player_input.start_with?('q')
      prompt('bye')
      exit
    elsif VALID_INPUTS.include?(player_input)
      break
    end
    prompt('invalid_input')
  end

  VALID_CHOICES.each do |choice|
    return choice if choice.start_with?(player_input)
  end
end

def display_choices(choices)
  prompt(
    'choices_made_were',
    {
      player_choice: choices[:player_choice],
      comp_choice: choices[:comp_choice]
    }
  )
end

def evaluate_round(choices)
  if WIN_PAIRS.include?([choices[:player_choice], choices[:comp_choice]])
    'player_won_round'
  elsif WIN_PAIRS.include?([choices[:comp_choice], choices[:player_choice]])
    'computer_won_round'
  else
    'a_tie'
  end
end

def update_scores(scores, round_result)
  if round_result == 'player_won_round'
    scores[:player_score] += 1
  elsif round_result == 'computer_won_round'
    scores[:computer_score] += 1
  end
end

def display_scores(scores)
  prompt(
    'current_scores_are',
    {
      player_score: scores[:player_score],
      computer_score: scores[:computer_score]
    }
  )
end

def game_winner?(scores)
  scores[:player_score] == 5 || scores[:computer_score] == 5
end

def display_game_winner(scores)
  prompt("computer_won_game") if scores[:computer_score] == 5
  prompt("player_won_game") if scores[:player_score] == 5
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
  scores = {
    player_score: 0,
    computer_score: 0
  }

  loop do
    choices = {
      player_choice: request_choice(),
      comp_choice: VALID_CHOICES.sample()
    }

    display_choices(choices)
    round_result = evaluate_round(choices)
    prompt(round_result)
    update_scores(scores, round_result)
    display_scores(scores)
    if game_winner?(scores)
      display_game_winner(scores)
      break
    end
  end

  answer = request_rematch()
  break unless answer.downcase.start_with?('c')
end
