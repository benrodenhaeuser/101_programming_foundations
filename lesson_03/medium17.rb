answer = 42

def mess_with_it(some_number)
  some_number += 8 # anwer is not changed
end

new_answer = mess_with_it(answer)

p new_answer # => 50
p answer - 8 # => 34
