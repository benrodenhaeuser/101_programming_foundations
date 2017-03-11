def rolling_buffer1(buffer, max_buffer_size, new_element)
  buffer << new_element
  buffer.shift if buffer.size > max_buffer_size
  buffer
end

def rolling_buffer2(buffer, max_buffer_size, new_element)
  buffer = buffer + [new_element]
  buffer.shift if buffer.size > max_buffer_size
  buffer
end

buffer = ["Ben"]
rolling_buffer2(buffer, 1, "Julia")
p buffer



# What is the difference?

# Both methods have the same return value, BUT:
# rolling_buffer1 mutates the argument `buffer`
# rolling_buffer2 does not mutate `input_array`
