def calculate_bonus(salary, bonus)
  if bonus == true
   salary / 2
  else
   0
  end
end

puts calculate_bonus(1200, true)
