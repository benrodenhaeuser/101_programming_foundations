class Array
  def all_index?
    result = true
    for index in (0...self.length)
      result = false unless yield(index)
    end
    result
  end
end

array = [10, 100, 1000]

result = array.all_index? do |index|
  array[index] % 2 == 0
end

p result

# but this new Array method is not really needed ... we can also use: 
(0...array.size).all? do |index|
  array[index] % 2 == 0
end
