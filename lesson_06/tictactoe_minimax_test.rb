# testing minimax

# game mechanics

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
  win_strings = /
    #{M1}#{M2}#{M3}.*|.*#{M4}#{M5}#{M6}.*|.*#{M7}#{M8}#{M9}|
    #{M1}.*#{M4}.*#{M7}.*|.*#{M2}.*#{M5}.*#{M8}.*|.*#{M3}.*#{M6}.*#{M9}|
    #{M1}.*#{M5}.*#{M9}|.*#{M3}.*#{M5}.*#{M7}.*
  /x
  # debug
  # p moves_so_far_of(player, board).join
  # p moves_so_far_of(player, board).join.match(win_strings)
  !!moves_so_far_of(player, board).join.match(win_strings)
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

def undo(move, board)
  board[move] = false
end

# minimax methods

# best_move and value_of follow a similar logic, they should really be one method
# perhaps we could pass around a hash
# { value: X, moves: [x,y ,z] }, where value is the value of the current board, and moves are the best moves

# in the method that gets a computer move:
# evaluate(board, :computer)[:best_moves].sample

def evaluate(board, player, player_to_move)
  evaluation = { value: nil, best_moves: [] }

  if winner?(board, player)
    evaluation[value] = 1
  elsif winner?(board, opponent_of(player))
    evaluation[value] = -1
  elsif full?(board)
    evaluation[value] = 0
  else
    move_scores = []

    case player_to_move
    when opponent_of(player)
      available_moves(board).each do |move|
        update(board, move, player_to_move)
        move_scores << evaluate(board, player, player)[:value]
        undo(move, board)
      end
      evaluation[:value] = move_scores.min
      available_moves(board).each_with_index do |move, index|
        if move_scores[index] == evaluation[:value]
          evaluation[:best_moves] << move
        end
      end
    when player
      available_moves(board).each do |move|
        update(board, move, player_to_move)
        move_scores << evaluate(board, player, player)[:value]
        undo(move, board)
      end
      evaluation[:value] = move_scores.min
      available_moves(board).each_with_index do |move, index|
        if move_scores[index] == evaluation[:value]
          evaluation[:best_moves] << move
        end
      end
    end
  end

  evaluation
end

def best_move(player, board)
  resulting_board_scores = []

  available_moves(board).each do |move|
    update(board, move, player)
    resulting_board_scores << value_of(board, player, opponent_of(player))
    undo(move, board)
  end

  max = resulting_board_scores.max
  index = resulting_board_scores.index(max)
  available_moves(board)[index]
end

def value_of(board, player, player_to_move)
  if winner?(board, player)
    1
  elsif winner?(board, opponent_of(player))
    -1
  elsif full?(board)
    0
  else
    case player_to_move
    when opponent_of(player)
      next_board_values = []
        available_moves(board).each do |move|
          update(board, move, player_to_move)
          next_board_values << value_of(board, player, player)
          undo(move, board)
        end
      next_board_values.min
    when player
      next_board_values = []
      available_moves(board).each do |move|
        update(board, move, player_to_move)
        next_board_values << value_of(board, player, opponent_of(player))
        undo(move, board)
      end
      next_board_values.max
    end
  end
end

# tests

# does the new winner? method work?
board = {
  "1"=>:computer, "2"=>:computer, "3"=>:computer,
  "4"=>:user, "5"=>:user, "6"=>false,
  "7"=>false, "8"=>false, "9"=>false
}

p winner?(board, :computer)


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

# p value_of(board, :user, :user) # 1 that is correct.
# p best_moves(:user, board) # ["4", "6", "7", "9"] (correct, either way results in a win)

# "RIGGED" BOARD
board = {
  "1"=>false, "2"=>:user, "3"=>false,
  "4"=>false, "5"=>false, "6"=>:user,
  "7"=>:computer, "8"=>:computer, "9"=>:user
}

# p value_of(board, :computer, :computer) # -1 (correct)
# p best_moves(:computer, board)  # ["1", "3", "4", "5"] (correct, computer will lose anyway)

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


# COMPLICATED EVALUATE METHOD WITH "SYMMETRY"

# def evaluate(board, player, player_to_move)
#   evaluation = { value_of_position: nil, best_moves: [] }
#
#   if winner?(board, player)
#     evaluation[:value_of_position] = 1
#   elsif winner?(board, opponent_of(player))
#     evaluation[:value_of_position] = -1
#   elsif full?(board)
#     evaluation[:value_of_position] = 0
#   else
#     moves_scores = []
#
#     case player_to_move
#     when opponent_of(player)
#       available_moves(board).each do |move|
#         update(board, move, player_to_move)
#         moves_scores << evaluate(board, player, player)[:value_of_position]
#         undo(move, board)
#       end
#       evaluation[:value_of_position] = moves_scores.min
#       available_moves(board).each_with_index do |move, index|
#         if moves_scores[index] == evaluation[:value_of_position]
#           evaluation[:best_moves] << move
#         end
#       end
#     when player
#       available_moves(board).each do |move|
#         update(board, move, player_to_move)
#         moves_scores << evaluate(board, player, opponent_of(player))[:value_of_position]
#         undo(move, board)
#       end
#       evaluation[:value_of_position] = moves_scores.max
#       available_moves(board).each_with_index do |move, index|
#         if moves_scores[index] == evaluation[:value_of_position]
#           evaluation[:best_moves] << move
#         end
#       end
#     end
#   end
#
#   evaluation
# end
