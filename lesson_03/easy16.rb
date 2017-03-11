# show two different ways to prepend "Four score and " in front of the following string:

famous_words = "seven years ago..."
famous_words = "Four score and " << famous_words
p famous_words

famous_words = "seven years ago..."
famous_words = "Four score and" + famous_words
p famous_words

famous_words = "seven years ago..."
famous_words.prepend("Four score and ")
p famous_words
