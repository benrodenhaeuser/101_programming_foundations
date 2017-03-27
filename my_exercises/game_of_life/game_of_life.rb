# game of life

GLIDER =
  [
    [false, true, false, false],
    [false, false, true, false],
    [true, true, true, false],
    [false, false, false, false]
  ]

SIZE = 16

def start(seed, size)
  grid = create_empty_square_grid(size)
  embed!(seed, grid)
  game_of_life(grid)
end

def create_empty_square_grid(size)
  grid = Array.new
  size.times do
    grid << []
  end
  grid.each do |row|
    size.times do
      row << false
    end
  end
  grid
end

def embed!(seed, grid)
  top_left = grid.size / 2 - seed.size / 2
  (top_left...seed.size + top_left).each do |row_index|
    (top_left...seed.size + top_left).each do |col_index|
      grid[row_index][col_index] =
        seed[row_index - top_left][col_index - top_left]
    end
  end
end

def game_of_life(grid)
  loop do
    system 'clear'
    display(grid)
    4.times { puts }
    sleep 0.2
    break if dead?(grid)
    tick!(grid)
  end
end

# rubocop: disable Metrics/AbcSize
def neighbours(row, col, grid)
  rowplus1 = (if row == grid.size - 1 then 0 else row + 1 end)
  colplus1 = (if col == grid.size - 1 then 0 else col + 1 end)

  [grid[row - 1][col - 1], grid[row - 1][col], grid[row - 1][colplus1],
   grid[row][col - 1], grid[row][colplus1],
   grid[rowplus1][col - 1], grid[rowplus1][col], grid[rowplus1][colplus1]]
end
# rubocop: enable Metrics/AbcSize

def alive?(cell)
  cell
end

def count_alive(cells)
  cells.count { |cell| alive?(cell) }
end

def dead?(grid)
  grid.all? do |row|
    row.all? do |cell|
      !alive?(cell)
    end
  end
end

def tick!(grid)
  next_grid = build_next_grid(grid)
  overwrite_values!(grid, next_grid)
end

def build_next_grid(grid)
  next_grid = create_empty_square_grid(grid.size)

  grid.each_with_index do |row, row_index|
    row.each_with_index do |cell, col_index|
      alive_neighbours = count_alive(neighbours(row_index, col_index, grid))

      next_grid[row_index][col_index] =
        if (alive?(cell) && alive_neighbours == 2) || alive_neighbours == 3
          true
        else
          false
        end
    end
  end

  next_grid
end

def overwrite_values!(grid, next_grid)
  grid.each_with_index do |row, row_index|
    row.each_index do |col_index|
      grid[row_index][col_index] = next_grid[row_index][col_index]
    end
  end
end

def display(grid)
  display_grid = create_empty_square_grid(grid.size)

  grid.each_with_index do |row, row_index|
    row.each_with_index do |cell, col_index|
      if alive?(cell)
        display_grid[row_index][col_index] = "\u25FD".encode('utf-8')
      else
        display_grid[row_index][col_index] = "\u25FE".encode('utf-8')
      end
    end
  end

  display_strings = []
  display_grid.each { |row| display_strings << row.join }
  puts display_strings
end

start(GLIDER, SIZE)
