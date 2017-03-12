def select_fruit(produce)
  keys = produce.keys
  selected = { }
  counter = 0
  loop do
    break if counter == keys.length # has to be here in case produce is empty!
    if produce[keys[counter]] == "fruit"
      selected[keys[counter]] = "fruit"
    end
    counter += 1
  end
  selected
end

hsh = { :one => "fruit", :two => "fruit", :three => "vegetable" }

p select_fruit(hsh)
