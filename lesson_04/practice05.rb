flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# find the index of the first name that starts with "Be"

index_of_first_be = nil

flintstones.each_with_index do |elem, index|
  if elem.start_with?("Be")
    index_of_first_be = index
  end
end

p index_of_first_be

# or, shorter, with the index method:
index_of_first_be = flintstones.index { |name| name.start_with?("Be") }

p index_of_first_be
