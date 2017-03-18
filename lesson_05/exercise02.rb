# sort following array of hashes by year of publication of each book, ascending (from earliest to latest)

books = [
  {title: 'One Hundred Years of Solitude', author: 'Gabriel Garcia Marquez', published: '1967'},
  {title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', published: '1925'},
  {title: 'War and Peace', author: 'Leo Tolstoy', published: '1869'},
  {title: 'Ulysses', author: 'James Joyce', published: '1922'}
]


sorted_books = books.sort_by { |book| book[:published].to_i }
p sorted_books

# actually, we did not even need to convert to integer for comparison.
# because here, string order and integer order coincide.
