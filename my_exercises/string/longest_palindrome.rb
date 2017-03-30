# Find the longest palindromic substring of a given string
# Definition of palindrome: string such that string.reverse == string

# Analysis

=begin

IO:
string/string

(output is substring of input)

Algo:

- if string is a palindrome, return string
- else:
    recursively look for longest palindrome in
    (string without first char) and (string without last char)

Pseudocode:

def palindrome(string)
  if reverse(string) is the same as string
    return string
  else
    if palindrome(string without first character) is longer than
        palindrome(string without last character)
        then return palindrome(string without first character)
    else
        return palindrome(string without last character)
    end
end

=end

def palindrome(string)
    if string.reverse == string && string.size > 1
        string
    else
        string_without_first = string.slice(1..string.size - 1)
        string_without_last = string.slice(0..string.size - 2)

        if palindrome(string_without_first).size >
            palindrome(string_without_last).size
            palindrome(string_without_first)
        else
            palindrome(string_without_last)
        end
    end
end

p palindrome("anna")
p palindrome("brightannaruby")
p palindrome("ff abcdefedcba more")

# Jerome's solution:
# def palindromic?(str)
#    str == str.reverse
# end
#
# def slices(str)
#  (returns all substrings of str)
# end
#
# def longest_palindrome(str)
#  (iterate over slices(str) and find longest string with palindromic?(str) )
# end
