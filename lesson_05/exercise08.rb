hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

# write some code to output all the vowels from the strings

string = ""
hsh.values.each do |array|
  array.each do |elem|
    string << elem
  end
end
result = string.split("").select do |elem|
  %w(a e i o u).include?(elem)
end
p result

# or if we wanted to have a string:
result = result.join
p result

# wanted: a solution that uses only each
vowels = %w(a e i o u)

hsh.each do |_, value|
  value.each do |word|
    word.chars.each do |char|
      puts char if vowels.include?(char)
    end
  end
end
