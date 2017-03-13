munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

# For each Munster family member, give it another key "age_group", with values
# among "adult", "senior", "kids"

# kids: 0..17
# adults: 18..64
# seniors: 65+

# my solution:

munsters.each do |key, munster|
  munster["age_group"] = "kid" if (0..17).cover?(munster["age"])
  munster["age_group"] = "adult" if (18..64).cover?(munster["age"])
  munster["age_group"] = "senior" if munster["age"] >= 65
end

p munsters


# Launch School solution:
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |name, details|
  case details["age"]
  when 0...18
    details["age_group"] = "kid"
  when 18...65
    details["age_group"] = "adult"
  else
    details["age_group"] = "senior"
  end
end
