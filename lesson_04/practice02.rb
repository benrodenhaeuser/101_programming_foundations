ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

numbers = ages.values
sum = 0
numbers.each { |num| sum += num}

p sum
