# incomplete code

def sort(array)
  sorted = []
  array.each do |elem|
    insert(elem, sorted)
  end
  sorted
end

def insert(value, sorted)
  if sorted == []
    sorted[0] = value
  else
    loop do
      if value <= sorted[0]
        sorted.insert(index, value)
        break
      end
      index += 1
    end
  end
end

p sort([10, 5, 3, 0])
