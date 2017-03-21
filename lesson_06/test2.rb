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
