munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

def deep_copy(obj)
  Marshal.load(Marshal.dump(obj))
end

def mess_with_demographics(demo_hash)
  copy = deep_copy(demo_hash)
  copy.values.each do |family_member|
    family_member["age"] += 42
    family_member["gender"] = "other"
  end
end

# first intuition: basically messes up everything
mess_with_demographics(munsters)
p munsters
# so, yes, everything is messed up
