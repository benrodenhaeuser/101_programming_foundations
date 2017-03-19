require 'yaml'
MESSAGES = YAML.load_file('./my_tictactoe_config.yml')

# setup

PLAYERS = [:human, :computer]
LEGAL_MOVES = (1..9)
WIN_POSITIONS = [
  [1, 2, 3], [4, 5, 6], [7, 8, 9], # winning rows
  [1, 4, 7], [2, 5, 8], [3, 6, 9], # winning columns
  [1, 5, 9], [3, 5, 7]             # winning diagonals
]
MOVES_TO_CHOICES = {
  1 => 'tl', 2 => 'tm', 3 => 'tr',
  4 => 'ml', 5 => 'mm', 6 => 'mr',
  7 => 'bl', 8 => 'bm', 9 => 'br'
}
CHOICES_TO_MOVES = MOVES_TO_CHOICES.invert

def initialize_board
  board = {}
  LEGAL_MOVES.each { |move| board[move] = false }
  board
end

# display methods

def prompt(message, subst = {})
  message = MESSAGES[message] % subst
  puts "=> #{message}"
end

def display_board(board)
  pretty_board = convert_to_display(board)

  puts
  puts "    #{pretty_board[1]} | #{pretty_board[2]} | #{pretty_board[3]} "
  puts "   -----------"
  puts "    #{pretty_board[4]} | #{pretty_board[5]} | #{pretty_board[6]} "
  puts "   -----------"
  puts "    #{pretty_board[7]} | #{pretty_board[8]} | #{pretty_board[9]} "
  puts
end

def convert_to_display(board)
  pretty_board = {}
  board.each do |key, _|
    case board[key]
    when false     then pretty_board[key] = ' '
    when :computer then pretty_board[key] = 'C'
    when :human    then pretty_board[key] = 'Y'
    end
  end
  pretty_board
end

def display_winner(winner)
  case winner
  when :computer then prompt('computer_wins')
  when :human then prompt('human_wins')
  end
end

def display_tie
  prompt('a_tie')
end

# available moves and choices

def available_moves(board)
  LEGAL_MOVES.select { |move| !board[move] }
end

def available_choices(board)
  available_moves(board).map { |move| MOVES_TO_CHOICES[move] }
end

def full?(board)
  available_moves(board) == []
end

# evaluate the game position

def determine_winner(board)
  eval = PLAYERS.select do |player|
    moves_so_far = LEGAL_MOVES.select { |move| board[move] == player }

    WIN_POSITIONS.any? do |position|
      position.all? do |move|
        moves_so_far.include?(move)
      end
    end
  end
  eval.first
end

def winner?(board)
  determine_winner(board) != nil
end

# players make their moves

def computer_moves(board)
  unless full?(board) || winner?(board)
    computer_move = available_moves(board).sample
    board[computer_move] = :computer
  end
end

def human_moves(board)
  loop do
    prompt('request_choice', { choices: available_choices(board).join(", ") })
    print '   '
    human_choice = gets.chomp
    human_move = CHOICES_TO_MOVES[human_choice]
    if available_moves(board).include?(human_move)
      board[human_move] = :human
      break
    end
    prompt('invalid_choice')
  end
end

# choice to replay

def another_game?
  loop do
    prompt('another_game?')
    print '   '
    answer = gets.chomp
    if answer == 'y'
      return true
    elsif answer == 'n'
      return false
    end
    prompt('invalid_choice')
  end
end

# game loop

loop do
  system "clear"
  board = initialize_board

  prompt('welcome')
  prompt('explain_board')
  display_board(board)
  prompt('explain_moves')

  loop do
    human_moves(board)
    computer_moves(board)

    display_board(board)
    if winner?(board)
      display_winner(determine_winner(board))
      break
    elsif full?(board)
      display_tie
      break
    end
  end

  break unless another_game?
end

prompt('bye')
