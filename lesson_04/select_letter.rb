def select_letter(sentence, letter)
  occurences = ""
  index = 0

  loop do
    break if index == sentence.size

    if sentence[index].match(letter)
      occurences << letter
    end

    index += 1
  end

  occurences
end

sentence = "What a beautiful day"
p select_letter(sentence, "a").size # => 4
# ^ "a" occurs 4 times in sentence
