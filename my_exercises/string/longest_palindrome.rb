# Find the longest palindromic substring of a given string
# Definition of palindrome: string such that string.reverse == string

# Analysis

=begin

IO:
string/string

(output is substring of input)

Analysis:
This problem does not necessarily have a unique solution.
What if there a several maximal palindromes that have the same length?
On first pass, we will simply look to return an arbitrary one.

Algo:

- if string is a palindrome, return string
- else:
    recursively find longest palindrome in
    (string without first char) and (string without last char)

Pseudocode:

def palindrome(string)
  if reverse(string) == string
    return string
  else
    if palindrome(string without first character) is longer than
        palindrome(string without last character)
        then return palindrome(string without first character)
    else
        return palindrome(string without last character)
    end
end

Implementation:

def palindrome(string)
  if string.reverse == string
    string
  else
    right_string = string.slice(1..string.size - 1)
    left_string = string.slice(0..string.size - 2)

    palin_right_string = palindrome(right_string)
    palin_left_string = palindrome(left_string)

    if palin_right_string.size > palin_left_string.size
      palin_right_string
    else
      palin_left_string
    end
  end
end

Now returning to the initial problem: What if we wanted to return
all maximal palindromic substrings, rather than a single arbitrary one of them?

To do this, we need to maintain a *list* of palindromes.

Algo:

if given string is palindrome,
then palindromes(string) is the list [string]

else
 left_string = drop first element from string
 right_string = drop last element from string

 if elements contained in palindromes(left_string) are longer than the ones
 in palindromes(right_string):
    palindromes(string) is palindromes(left_string)

 if the ones in palindromes(right_string) are longer:
    palindromes(string) is palindromes(right_string)

 else:
    palindromes(string) is concatenation of palindromes(left_string) and
    palindromes(right_string)

 since list of palindromes might contain duplicates:
 throw them out before returning list of palindromes


 NOTE:
 this algorithm is quite inefficient, because it is not excluded that it
 will visit substrings many times. but it's simple!

=end

def palindromes(string)
  if string.reverse == string
    palindromes = [string]
  else
    right_string = string.slice(1..string.size - 1)
    left_string = string.slice(0..string.size - 2)

    palins_right = palindromes(right_string)
    palins_left = palindromes(left_string)

    if palins_right.first.size > palins_left.first.size
      palindromes = palins_right
    elsif palins_right.first.size < palins_left.first.size
      palindromes = palines_left
    else
      palindromes = palins_left + palins_right
    end
  end

  palindromes.uniq
end

p palindromes("annabrznnzghynny") # ["anna", "znnz", "ynny"]
