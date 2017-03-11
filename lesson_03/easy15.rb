# determine whether some number lies between 10 and 100

p (10..100).cover?(42) # => true

# BONUS:

# determine whether a range of numbers covers another range of numbers:

class Range
  def covers?(range)
    covered_part = range.select do |elem|
      self.cover?(elem)
    end
    covered_part == range.to_a
  end
end

p (10..100).covers?(20..40) # => true
p (10..100).covers?(90..110) # => false

# without extending the range class:

def covers?(range1, range2)
  covered_part = range2.select do |elem|
    range1.cover?(elem)
  end
  covered_part == range2.to_a
end

p covers?(10..100, 20..40) # => true
p covers?(10..100, 90..110) # => false
