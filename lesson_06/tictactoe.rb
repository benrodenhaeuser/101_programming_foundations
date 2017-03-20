# tic tac toe

#  X |   | X
# -----------
#    | O |
# -----------
#    | O |

require 'yaml'
MESSAGES = YAML.load_file('./tictactoe.yml')

PLAYERS = [:user, :computer]
LEGAL_MOVES = (1..9)
CENTER_SQUARE = 5

FIRST_TURN = :choose # options: :user, :computer, :choose
NUMBER_OF_WINS_TO_WIN_THE_GAME = 5

WIN_LINES = [
  [1, 2, 3], [4, 5, 6], [7, 8, 9],
  [1, 4, 7], [2, 5, 8], [3, 6, 9],
  [1, 5, 9], [3, 5, 7]
]

USER_CHOICES = %w[TL TM TR ML MM MR BL BM BR]

MOVES_TO_CHOICES = Hash.new { |key, value| key[value] = [] }

LEGAL_MOVES.each do |move|
  MOVES_TO_CHOICES[move] = USER_CHOICES[move - 1]
end

CHOICES_TO_MOVES = MOVES_TO_CHOICES.invert

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

  if threats_for(:user, board) != []
    threats_for(:user, board).sample # 'offense'
  elsif threats_for(:computer, board) != []
    threats_for(:computer, board).sample # 'defense'
  elsif available_moves(board).include?(CENTER_SQUARE)
    CENTER_SQUARE
  else
    available_moves(board).sample
  end
end

def threats_for(player, board)
  LEGAL_MOVES.select { |move| threat_for?(player, move, board) }
end

def threat_for?(player, move, board)
  if available_moves(board).include?(move)
    evaluation_board = board.clone
    update(evaluation_board, move, other(player))

    winner?(evaluation_board, other(player))
  end
end

def get_user_move(board)
  user_choice = request_user_choice(board)
  CHOICES_TO_MOVES[user_choice]
end

def update(board, move, player)
  case player
  when :computer then board[move] = :computer
  when :user then board[move] = :user
  end
end

def winner?(board, player)
  WIN_LINES.any? do |line|
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
end

def wait_for_user
  prompt('please_press_enter')
  print '   '
  gets
  sleep 0.1
end

def request_turn_decision
  loop do
    prompt('want_to_begin?')
    print '   '
    answer = gets.chomp
    case answer.upcase
    when 'Y' then return :user
    when 'N' then return :computer
    end
    prompt('invalid_choice')
  end
end

def announce_who_begins(player)
  case player
  when :computer then prompt('computer_begins')
  when :user then prompt('user_begins')
  end
  sleep 0.1
end

def display(board)
  display_board = convert_for_display(board)

  puts
  puts "    #{display_board[1]} | #{display_board[2]} | #{display_board[3]} "
  puts "   -----------"
  puts "    #{display_board[4]} | #{display_board[5]} | #{display_board[6]} "
  puts "   -----------"
  puts "    #{display_board[7]} | #{display_board[8]} | #{display_board[9]} "
  puts
end

def convert_for_display(board)
  display_board = {}
  board.each do |key, _|
    case board[key]
    when false     then display_board[key] = ' '
    when :computer then display_board[key] = 'X'
    when :user     then display_board[key] = 'O'
    end
  end
  display_board
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
  available_moves(board).map { |move| MOVES_TO_CHOICES[move] }
end

def joinor(array, delimiter = ', ', word = 'or')
  case array.size
  when 0 then ''
  when 1 then array.first
  when 2 then array.join(" #{word} ")
  else
    array[-1] = "#{word} #{array.last}"
    array.join(delimiter)
  end
end

def parrot(player, move)
  move_as_choice = MOVES_TO_CHOICES[move]
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
  if FIRST_TURN == :choose
    player = request_turn_decision
  else
    wait_for_user
    player = FIRST_TURN
  end
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
    if scores[player] == NUMBER_OF_WINS_TO_WIN_THE_GAME
      announce_overall_winner(player)
      break
    end
    player = other(player)

    wait_for_user
  end

  break prompt('bye') unless user_wants_to_play_again?
end
