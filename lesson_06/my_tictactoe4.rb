require 'yaml'
MESSAGES = YAML.load_file('./my_tictactoe_config3.yml')

PLAYERS = [:user, :computer]
LEGAL_MOVES = (1..9)
CENTER_SQUARE = 5 # only square to occur in four winning lines

WINNING_LINES = [
  [1, 2, 3], [4, 5, 6], [7, 8, 9], # winning rows
  [1, 4, 7], [2, 5, 8], [3, 6, 9], # winning columns
  [1, 5, 9], [3, 5, 7]             # winning diagonals
]

USER_CHOICES = %w[TL TM TR ML MM MR BL BM BR] # top left, top middle, ...

MOVES_TO_USER_CHOICES = Hash.new { |key, value| key[value] = [] }
LEGAL_MOVES.each do |move|
  MOVES_TO_USER_CHOICES[move] = USER_CHOICES[move - 1]
end
USER_CHOICES_TO_MOVES = MOVES_TO_USER_CHOICES.invert

# game mechanics

def initialize_board
  board = {}
  LEGAL_MOVES.each { |move| board[move] = false }
  board
end

def available_moves(board)
  LEGAL_MOVES.select { |move| board[move] == false }
end

def get_move(player, board)
  case player
  when :user then get_user_move(board)
  when :computer then get_computer_move(board)
  end
end

def get_computer_move(board)
  sleep 0.5

  if immediate_threats_for(:user, board)
    immediate_threats_for(:user, board).sample
  elsif immediate_threats_for(:computer, board)
    immediate_threats_for(:computer, board).sample
  elsif available_moves(board).include?(CENTER_SQUARE)
    CENTER_SQUARE
  else available_moves(board).sample
  end
end

def immediate_threats_for(player, board)
  false
end

def get_user_move(board)
  user_choice = request_user_choice(board)
  USER_CHOICES_TO_MOVES[user_choice]
end

def update(board, move, player)
  case player
  when :computer then board[move] = :computer
  when :user then board[move] = :user
  end
end

def winner?(board, player)
  WINNING_LINES.any? do |line|
    line.all? do |square|
      LEGAL_MOVES.select { |move| board[move] == player }.include?(square)
    end
  end
end

def full?(board)
  available_moves(board) == []
end

def other(player)
  case player
  when :computer then :user
  when :user then :computer
  end
end

# user interface

def prompt(message, subst = {})
  message = MESSAGES[message] % subst
  puts "=> #{message}"
end

def welcome_the_user
  prompt('welcome')
  prompt('explain_board')
  prompt('explain_moves')
  prompt('explain_winning_conditions')
  prompt('explain_cointoss')
end

def wait_for_user
  prompt('please_press_enter')
  print '   '
  gets
  sleep 0.1
end

def announce_who_begins(player)
  case player
  when :computer then prompt('computer_begins')
  when :user then prompt('user_begins')
  end
  sleep 0.1
end

def display(board)
  pretty_board = convert_for_output(board)

  puts
  puts "    #{pretty_board[1]} | #{pretty_board[2]} | #{pretty_board[3]} "
  puts "   -----------"
  puts "    #{pretty_board[4]} | #{pretty_board[5]} | #{pretty_board[6]} "
  puts "   -----------"
  puts "    #{pretty_board[7]} | #{pretty_board[8]} | #{pretty_board[9]} "
  puts
end

def convert_for_output(board)
  pretty_board = {}
  board.each do |key, _|
    case board[key]
    when false     then pretty_board[key] = ' '
    when :computer then pretty_board[key] = 'C'
    when :user     then pretty_board[key] = 'Y'
    end
  end
  pretty_board
end

def request_user_choice(board)
  loop do
    prompt('request_choice', { choices: joinor(available_choices(board)) })
    print '   '
    user_choice = gets.chomp.upcase
    if available_choices(board).include?(user_choice)
      return user_choice
    end
    prompt('invalid_choice')
  end
end

def available_choices(board)
  available_moves(board).map { |move| MOVES_TO_USER_CHOICES[move] }
end

def joinor(array, delimiter = ',', joinword = 'or')
  string = array[0].clone
  index = 1
  while index < array.size - 1
    string << "#{delimiter} #{array[index]}"
    index += 1
  end
  if array.size > 1
    string << "#{delimiter} #{joinword} #{array[array.size - 1]}"
  end
  string
end

def parrot(player, move)
  move_as_choice = MOVES_TO_USER_CHOICES[move]
  case player
  when :computer then prompt('computer_chose', { move: move_as_choice })
  when :user then prompt('user_chose', { move: move_as_choice })
  end
end

def announce_winner(player)
  case player
  when :computer then prompt('computer_wins')
  when :user then prompt('user_wins')
  end
end

def present(scores)
  prompt(
    'the current_scores_are',
    {
      user_score: scores[:user],
      computer_score: scores[:computer]
    }
  )
end

def announce_overall_winner(player)
  case player
  when :computer
    prompt('the_overall_winner_is', { winner: 'the computer' })
  when :user
    prompt('the_overall_winner_is', { winner: 'you' })
  end
end

def user_wants_to_play_again?
  loop do
    prompt('another_game?')
    print '   '
    answer = gets.chomp
    if answer.upcase == 'Y'
      return true
    elsif answer.upcase == 'N'
      return false
    end
    prompt('invalid_choice')
  end
end

# game loop

loop do
  system "clear"
  welcome_the_user
  wait_for_user
  player = PLAYERS.sample
  announce_who_begins(player)

  scores = {
    computer: 0,
    user: 0
  }

  loop do
    board = initialize_board
    display(board)

    loop do
      move = get_move(player, board)
      parrot(player, move)
      update(board, move, player)
      display(board)

      if winner?(board, player)
        announce_winner(player)
        scores[player] += 1
        break
      elsif full?(board)
        prompt('its_a_tie')
        break
      end

      player = other(player)
    end

    present(scores)
    if scores[player] == 2 # TODO: should really be 5
      announce_overall_winner(player)
      break
    end
    player = other(player)

    wait_for_user
  end

  break prompt('bye') unless user_wants_to_play_again?
end
