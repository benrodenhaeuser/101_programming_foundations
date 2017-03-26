# populations and transitions

def create_empty_grid(size)
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

def my_population # here: a 13 x 13 grid
  [
    [false, false, false, false, false, false, false,
      false, false, false, false, false, false],
    [false, false, false, false, false, false, false,
      false, false, false, false, false, false],
    [false, false, true, false, false, false, false,
      false, false, false, false, false, false],
    [false, false, false, true, false, false, false,
      false, false, false, false, false, false],
    [false, true, true, true, false, false, false,
      false, false, false, false, false, false],
    [false, false, false, false, false, false, false,
      false, false, false, false, false, false],
    [false, false, false, false, false, false, false,
      false, false, false, false, false, false],
    [false, false, false, false, false, false, false,
      false, false, false, false, false, false],
    [false, false, false, false, false, false, false,
      false, false, false, false, false, false],
    [false, false, false, false, false, false, false,
      false, false, false, false, false, false],
    [false, false, false, false, false, false, false,
      false, false, false, false, false, false],
    [false, false, false, false, false, false, false,
      false, false, false, false, false, false],
    [false, false, false, false, false, false, false,
      false, false, false, false, false, false]
  ]
end

def neighbours(row, col, grid)
  if row == grid.size - 1
    rowplus1 = 0
  else
    rowplus1 = row + 1
  end

  if col == grid.size - 1
    colplus1 = 0
  else
    colplus1 = col + 1
  end

  [grid[row - 1][col - 1], grid[row - 1][col], grid[row - 1][colplus1],
    grid[row][col-1], grid[row][colplus1],
    grid[rowplus1][col - 1], grid[rowplus1][col], grid[rowplus1][colplus1]
  ]
end

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
  next_grid = create_empty_grid(grid.size)
  next_grid.each_with_index do |row, row_index|
    row.each_index do |col_index|
      alive_neighbours = count_alive(neighbours(row_index, col_index, grid))
      case alive?(grid[row_index][col_index])
      when true
        if (alive_neighbours == 2 || alive_neighbours == 3)
          next_grid[row_index][col_index] = true
        else
          next_grid[row_index][col_index] = false
        end
      when false
        if alive_neighbours == 3
          next_grid[row_index][col_index] = true
        else
          next_grid[row_index][col_index] = false
        end
      end
    end
  end
  # display(next_grid) # debug
  grid.each_with_index do |row, row_index|
    row.each_index do |col_index|
      grid[row_index][col_index] = next_grid[row_index][col_index]
    end
  end
end

# display

def display(grid)
  display_grid = create_empty_grid(grid.size)
  grid.each_with_index do |row, row_index|
    row.each_index do |col_index|
      if alive?(grid[row_index][col_index])
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

# game loop
def start
  grid = my_population

  loop do
    system 'clear'
    display(grid)
    4.times { puts }
    sleep 0.2
    tick!(grid)
    system 'clear'
    display(grid)
    4.times { puts }
    break if dead?(grid)
  end
end

start
