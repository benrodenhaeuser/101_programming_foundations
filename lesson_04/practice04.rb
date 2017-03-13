ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

min = ages.values.first

ages.values.each do |value|
  if value < min
    min = value
  end
end

p min # 10 (that's Eddie)


# more succinctly:
min = ages.values.min # 10
