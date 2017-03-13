# implement a titleize method that capitalizes each word in a string

# my solution with each:

def titleize(sentence)
  sentence.split.each { |word| word.capitalize! }.join(" ")
end

# ^ note that we are using capitalize! here
# this is mandatory, because each returns self,
# so we have to mutate the array on which we call each

words = "the flintstones rock"
p titleize(words)
p words # not mutated

# Launch School solution with map:

def titleize_ls(sentence)
  sentence.split.map { |word| word.capitalize }.join(" ")
end

# ^ note that Launch School uses capitalize here
# this is ok because map returns a new array,
# so there is no need to mutate the array on which we call map

words = "the flintstones rock"
p titleize_ls(words)
p words # not mutated
