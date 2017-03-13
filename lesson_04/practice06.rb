flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# task: shorten each name to three characters

# option 1: do it in a non-destructive manner

abbreviated_flintstones = flintstones.map do |flintstone|
  flintstone.slice(0,3)
  # ^ or: flintstone[0, 3] which is a shorthand for flintstone.slice(0, 3)
end

p abbreviated_flintstones

# option 2: do it destructively

# first pass:
# max_length = length of longest flintstone name
# slice! each string starting at inde 3, up to max_length

max_length = 0
flintstones.each do |flintstone|
  if flintstone.size > max_length
    max_length = flintstone.size
  end
end


flintstones.each do |flintstone|
  flintstone.slice!(3..max_length)
end

p flintstones

# ^ complicated solution!

# second pass: use reverse indexing

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flintstones.each do |flintstone|
  flintstone.slice!(3..-1)
end

p flintstones
