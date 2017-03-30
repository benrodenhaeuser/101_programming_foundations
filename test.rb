=begin
I/O:
I: string
O: another string (which is a substring of input)

Example: input is "abacdc" => What to return? "aba" and "cdc" => Return the
first one

longest_palindrome(string)

algorithm:
- if string is a palindrome, return string
- else:
    "search within some smaller subsequences for palindrome":
    namely: look in string without first character, and string without last character

pseudocode:

    def palindrome(string)
      if reverse(string) is the same as string
        return string
      else

        if palindrome(string without first character) is longer than
            palindrome(string without last character)
            ==> return palindrome(string without first character)

        else
            ==> return palindrome(string without last character)

        end

      end

=end

def palindrome(string)
    if string.size <= 1
      ''
    elsif string.reverse == string && string.size > 1
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



# def palindromic?(str)
#    str == str.reverse
# end
#
# def slices(str)
#
# end
#
# def longest_palindrome(str)
#
# end
