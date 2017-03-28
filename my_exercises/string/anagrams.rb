def anagrams(words)
  anagrams = Hash.new { |key, value| key[value] = [] }
  words.each { |word| anagrams[word.chars.sort.join] << word }
  anagrams.map { |_, value| value if value.size > 1 }
end

words =  ['demo', 'none', 'tied', 'evil', 'dome', 'mode', 'live',
          'fowl', 'veil', 'wolf', 'diet', 'vile', 'edit', 'tide',
          'flow', 'neon']

p anagrams(words)
# [["demo", "dome", "mode"], ["none", "neon"], ["tied", "diet", "edit", "tide"],
# ["evil", "live", "veil", "vile"], ["fowl", "wolf", "flow"]]
