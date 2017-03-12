class Array
  def my_select
    new_ary = []
    for elem in self
      return_value = yield(elem)
      if return_value
        new_ary << elem
      end
    end
    new_ary
  end
end

new_ary = [0, 1, 2].my_select do |elem|
  elem.odd?
end

p new_ary
# => [1]
