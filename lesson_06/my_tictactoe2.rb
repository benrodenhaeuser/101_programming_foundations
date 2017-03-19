require 'yaml'
MESSAGES = YAML.load_file('./my_tictactoe_config2.yml')

PLAYERS = [:human, :computer]

LEGAL_MOVES = (1..9)
MOVES_TO_CHOICES = {
  1 => 'TL', 2 => 'TM', 3 => 'TR',
  4 => 'ML', 5 => 'MM', 6 => 'MR',
  7 => 'BL', 8 => 'BM', 9 => 'BR'
}
CHOICES_TO_MOVES = MOVES_TO_CHOICES.invert

WIN_POSITIONS = [
  [1, 2, 3], [4, 5, 6], [7, 8, 9], # winning rows
  [1, 4, 7], [2, 5, 8], [3, 6, 9], # winning columns
  [1, 5, 9], [3, 5, 7]             # winning diagonals
]

def initialize_board
  board = {}
  LEGAL_MOVES.each { |move| board[move] = false }
  board
end

# displaying stuff to the user

def prompt(message, subst = {})
  message = MESSAGES[message] % subst
  puts "=> #{message}"
end

def welcome_the_user
  prompt('welcome')
  prompt('explain_board')
  prompt('explain_moves')
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
    when :human    then pretty_board[key] = 'Y'
    end
  end
  pretty_board
end

def coin_toss
  prompt('explain_turntaking')
  prompt('press_enter')
  print '   '
  gets
  sleep 0.2
end

def announce_who_begins(player)
  case player
  when :computer then prompt('computer_begins')
  when :human then prompt('human_begins')
  end
  sleep 0.3
end

def parrot(player, move)
  move_as_choice = MOVES_TO_CHOICES[move]
  case player
  when :computer then prompt('computer_chose', { move: move_as_choice })
  when :human then prompt('human_chose', { move: move_as_choice })
  end
end

def announce_winner(winner)
  case winner
  when :computer then prompt('computer_wins')
  when :human then prompt('human_wins')
  end
end

# moves and turns and winners

def available_moves(board)
  LEGAL_MOVES.select { |move| !board[move] }
end

def available_choices(board)
  available_moves(board).map { |move| MOVES_TO_CHOICES[move] }
end

def full?(board)
  available_moves(board) == []
end

def request_move(player, board)
  case player
  when :human then request_human_move(board)
  when :computer then request_computer_move(board)
  end
end

def request_computer_move(board)
    sleep 0.5
    available_moves(board).sample
end

def request_human_move(board)
  loop do
    prompt('request_choice', { choices: joinor(available_choices(board)) })
    print '   '
    human_choice = gets.chomp.upcase
    human_move = CHOICES_TO_MOVES[human_choice]
    if available_moves(board).include?(human_move)
      return human_move
    end
    prompt('invalid_choice')
  end
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

def update(board, move, player)
  case player
  when :computer then board[move] = :computer
  when :human then board[move] = :human
  end
end

def switch(player)
  case player
  when :computer then :human
  when :human then :computer
  end
end

def user_wants_another_game?
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

def compute_winner(board)
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
  compute_winner(board) != nil
end

# game loop

loop do
  system "clear"
  board = initialize_board
  welcome_the_user
  display(board)
  coin_toss
  current_player = PLAYERS.sample
  announce_who_begins(current_player)

  loop do
    move = request_move(current_player, board)
    update(board, move, current_player)
    parrot(current_player, move)
    display(board)
    if winner?(board)
      announce_winner(compute_winner(board))
      break
    elsif full?(board)
      prompt('its_a_tie')
      break
    end
    current_player = switch(current_player)
  end

  break unless user_wants_another_game?
end

prompt('bye')
