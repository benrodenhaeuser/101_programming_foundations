M1 = '1'; M2 = '2'; M3 = '3'
M4 = '4'; M5 = '5'; M6 = '6'
M7 = '7'; M8 = '8'; M9 = '9'

MOVES = [M1, M2, M3, M4, M5, M6, M7, M8, M9]

def initialize_board
  board = {}
  MOVES.each { |move| board[move] = false }
  board
end

def available_moves(board)
  MOVES.select { |move| board[move] == false }
end

def update(board, move, player)
  case player
  when :computer then board[move] = :computer
  when :user then board[move] = :user
  end
end

def winner?(board, player)
  win_lines = [
    [M1, M2, M3], [M4, M5, M6], [M7, M8, M9], # rows
    [M1, M4, M7], [M2, M5, M8], [M3, M6, M9], # cols
    [M1, M5, M9], [M3, M5, M7]                # diags
  ]

  win_lines.any? do |line|
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

def best_moves(player, board)
  available_moves(board).select do |move|
    evaluation_board = board.clone
    update(evaluation_board, move, player)
    value_of(evaluation_board, player, opponent_of(player)) == value_of(board, player, player)
  end
end

def value_of(board, player, player_to_move)
  if winner?(board, player)
    return 1
  elsif winner?(board, opponent_of(player))
    return -1
  elsif full?(board)
    return 0
  else
    case player_to_move
    when opponent_of(player)
      next_board_values =
        next_boards(board, opponent_of(player)).map do |next_board|
          value_of(next_board, player, player)
        end
      return next_board_values.min
    when player
      next_board_values =
        next_boards(board, player).map do |next_board|
          value_of(next_board, player, opponent_of(player))
        end
      return next_board_values.max
    end
  end
end

def next_boards(board, player)
  next_boards = []
  available_moves(board).each do |move|
    evaluation_board = board.clone
    update(evaluation_board, move, player)
    next_boards << evaluation_board
  end
  next_boards
end

# tests

# FRESH BOARD
board = initialize_board
# p value_of(board, :computer, :computer) # 0 ... that is correct.
# p best_moves(:computer, board) # program does not terminate ...

# BOARD WITH FOUR MOVES TAKEN
board = {
  "1"=>:computer, "2"=>:computer, "3"=>:user,
  "4"=>false, "5"=>false, "6"=>false,
  "7"=>false, "8"=>:user, "9"=>false
}

p value_of(board, :user, :user) # 1
p best_moves(:user, board) # ["4", "6", "7", "9"]




# TWO STEPS TO A FORCED WIN
board = {
  "1"=>:computer, "2"=>false, "3"=>:computer,
  "4"=>:user, "5"=>:computer, "6"=>:user,
  "7"=>false, "8"=>false, "9"=>false
}

# p value_of(board, :user, :user) # -1  THAT IS CORRECT
# p best_moves(:user, board) # ["2", "7", "8", "9"]  THAT IS CORRECT, EITHER WAY HE LOSES

# ONE STEP TO WIN
board = {
  "1"=>:computer, "2"=>:computer, "3"=>false,
  "4"=>:user, "5"=>:user, "6"=>false,
  "7"=>false, "8"=>false, "9"=>false
}

# p value_of(board, :computer, :computer) # 1 ==> CORRECT, computer can win with one move
# p value_of(board, :computer, :user) # -1 ==> CORRECT, user can win with one move
# p value_of(board, :user, :computer) # -1 ==> CORRECT, computer can win with one move
# p value_of(board, :user, :user) # 1 ==> CORRECT, user can win with one move
# p best_moves(:computer, board) # ["3"] ==> CORRECT, that's the winning move


# TIE

board = {
  "1"=>:computer, "2"=>:computer, "3"=>:user,
  "4"=>:user, "5"=>:user, "6"=>:computer,
  "7"=>:computer, "8"=>:user, "9"=>:user
}

# p value_of(board, :computer, :computer) # 0 ==> CORRECT
# p value_of(board, :computer, :user) # 0 ==> CORRECT
# p value_of(board, :user, :computer) # 0 ==> CORRECT
# p value_of(board, :user, :computer) # 0 ==> CORRECT
# p best_moves(:computer, board) #

# COMPUTER WIN

board = {
  "1"=>:computer, "2"=>:computer, "3"=>:computer,
  "4"=>:user, "5"=>:user, "6"=>false,
  "7"=>false, "8"=>false, "9"=>false
}

# p value_of(board, :computer, :computer) # 1 ==> correct
# p value_of(board, :computer, :user) # 1 ==> correct
# p value_of(board, :user, :computer) # -1 ==> correct
# p value_of(board, :user, :computer) # -1 ==> correct
# p best_moves(:computer, board) #
