# my solution
statement = "The Flintstones Rock"
char_count = Hash.new(0)
statement_array = statement.split("")
statement_array.delete(" ")
statement_array.each do |char|
  char_count[char] += 1
end

p char_count

# Launch School solution:
statement = "The Flintstones Rock"
result = {}
letters = ('A'..'Z').to_a + ('a'..'z').to_a
letters.each do |letter|
  letter_frequency = statement.scan(letter).count
  result[letter] = letter_frequency if letter_frequency > 0
end
p result
