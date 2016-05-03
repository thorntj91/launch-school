array = ["dog", "cat", "apple", "cola", "bottle"]

VOWELS = ["a", "e", "i", "o", "u"]

def remove_vowels(array)
  #loop over array
  #for each string check does it contain vowel, if it does remove it
  array.map do |string|
    split_string = string.split("")
    stripped_string = split_string.select { |letter| !VOWELS.include?(letter) }
    stripped_string.join("")
  end  
end


p remove_vowels(array)