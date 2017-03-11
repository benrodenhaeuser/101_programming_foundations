ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

p ages.key?("Herman") # true
p ages.key?("Spot") # false

p ages.has_key?("Herman") # true
p ages.has_key?("Spot") # false

p ages.include?("Herman") # true
p ages.include?("Spot") # false

p ages.member?("Herman") # true
p ages.member?("Spot") # false
