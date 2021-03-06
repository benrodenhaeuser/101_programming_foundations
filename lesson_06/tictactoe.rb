# tic tac toe

require 'yaml'
MESSAGES = YAML.load_file('./tictactoe3.yml')

PLAYERS = [:user, :computer]

# configure move variables below
M1 = '1'; M2 = '2'; M3 = '3'
M4 = '4'; M5 = '5'; M6 = '6'
M7 = '7'; M8 = '8'; M9 = '9'

MOVES = [M1, M2, M3, M4, M5, M6, M7, M8, M9]
CENTER_MOVE = M5

WIN_LINES = [
  [M1, M2, M3], [M4, M5, M6], [M7, M8, M9], # rows
  [M1, M4, M7], [M2, M5, M8], [M3, M6, M9], # cols
  [M1, M5, M9], [M3, M5, M7]                # diags
]

# configure who gets to start below (options are :user, :computer, :choose)
FIRST_TO_MOVE = :computer

# configure number of round wins sufficient to win the game below
WINS_TO_WIN_THE_GAME = 5

# game mechanics

def initialize_board
  board = {}
  MOVES.each { |move| board[move] = false }
  board
end

def available_moves(board)
  MOVES.select { |move| board[move] == false }
end

def get_move(player, board)
  case player
  when :user then request_user_move(board)
  when :computer then get_computer_move(board)
  end
end

def get_computer_move(board)
  sleep 0.5 # computer is thinking

  if threats_for(:user, board) != []
    threats_for(:user, board).sample # 'offense'
  elsif threats_for(:computer, board) != []
    threats_for(:computer, board).sample # 'defense'
  elsif available_moves(board).include?(CENTER_MOVE)
    CENTER_MOVE
  else
    available_moves(board).sample
  end
end

def threats_for(player, board)
  MOVES.select { |move| threat_for?(player, move, board) }
end

def threat_for?(player, move, board)
  if available_moves(board).include?(move)
    evaluation_board = board.clone
    update(evaluation_board, move, opponent_of(player))

    winner?(evaluation_board, opponent_of(player))
  end
end

def update(board, move, player)
  case player
  when :computer then board[move] = :computer
  when :user then board[move] = :user
  end
end

def winner?(board, player)
  WIN_LINES.any? do |line|
    line.all? do |move|
      moves_so_far_of(player, board).include?(move)
    end
  end
end

def moves_so_far_of(player, board)
  MOVES.select { |move| board[move] == player }
end

def full?(board)
  available_moves(board) == []
end

def opponent_of(player)
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
  prompt(
    'explain_moves',
    {
      m1: M1, m2: M2, m3: M3, m4: M4, m5: M5, m6: M6, m7: M7, m8: M8, m9: M9
    }
  )
  prompt('explain_winning_conditions', { rounds: WINS_TO_WIN_THE_GAME })
end

def wait_for_user
  prompt('please_press_enter')
  print '   '
  gets
  sleep 0.1
end

def request_turn_decision
  loop do
    prompt('want_to_have_first_turn?')
    print '   '
    answer = gets.chomp
    case answer.upcase
    when 'Y' then break :user
    when 'N' then break :computer
    else
      prompt('invalid_choice')
    end
  end
end

def display_state(board, scores)
  system 'clear'
  present(scores)
  display(board)
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

def display(board)
  d_board = convert_for_display(board)

  puts
  puts "    #{d_board[M1]} | #{d_board[M2]} | #{d_board[M3]} "
  puts "   -----------"
  puts "    #{d_board[M4]} | #{d_board[M5]} | #{d_board[M6]} "
  puts "   -----------"
  puts "    #{d_board[M7]} | #{d_board[M8]} | #{d_board[M9]} "
  puts
end

def convert_for_display(board)
  display_board = {}
  board.each_key do |key|
    case board[key]
    when false     then display_board[key] = ' '
    when :computer then display_board[key] = 'X'
    when :user     then display_board[key] = 'O'
    end
  end
  display_board
end

def request_user_move(board)
  loop do
    prompt('request_move', { moves: joinor(available_moves(board)) })
    print '   '
    user_move = gets.chomp.upcase
    if available_moves(board).include?(user_move)
      break user_move
    else
      prompt('invalid_choice')
    end
  end
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

def display_choice(player, move)
  case player
  when :computer then prompt('computer_chose', { move: move })
  when :user then prompt('user_chose', { move: move })
  end
end

def announce_winner(player)
  case player
  when :computer then prompt('computer_wins')
  when :user then prompt('user_wins')
  end
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
      break true
    elsif answer.upcase == 'N'
      break false
    else
      prompt('invalid_choice')
    end
  end
end

# game loop

loop do
  system 'clear'
  welcome_the_user
  if FIRST_TO_MOVE == :choose
    player = request_turn_decision
  else
    player = FIRST_TO_MOVE
    wait_for_user
  end

  scores = {
    computer: 0,
    user: 0
  }

  loop do
    board = initialize_board
    display_state(board, scores)

    loop do
      move = get_move(player, board)
      update(board, move, player)
      display_state(board, scores)
      display_choice(player, move)

      if winner?(board, player)
        announce_winner(player)
        scores[player] += 1
        break
      elsif full?(board)
        prompt('its_a_tie')
        break
      end

      player = opponent_of(player)
    end

    if scores[player] == WINS_TO_WIN_THE_GAME
      announce_overall_winner(player)
      break
    end
    player = opponent_of(player)

    wait_for_user
  end

  break prompt('bye') unless user_wants_to_play_again?
end
