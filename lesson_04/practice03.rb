ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

young_people = ages.select do |_, value|
  value <= 100
end

p young_people
