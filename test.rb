counter = 5
loop do
  puts "hello"
  require 'pry'; binding.pry
  counter -= 1
  break if counter == 0
end
