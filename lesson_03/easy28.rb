advice = "Few things in life are as important as house training your pet dinosaur."

p advice.slice!(/house.*/) # => "house training your pet dinosaur"
p advice # => "Few things are as important as "

# to get "Few things are as important as" as a return value, that's what we need to delete.
advice = "Few things in life are as important as house training your pet dinosaur."
p advice.slice!(0, advice.index("house"))
p advice

advice = "Few things in life are as important as house training your pet dinosaur."
p advice.slice(0, advice.index("house"))
p advice
