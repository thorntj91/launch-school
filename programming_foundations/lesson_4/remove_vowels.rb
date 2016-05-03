VOWELS = ['a', 'e', 'i', 'o', 'u']

def strip_vowels(strings)
  strings.each do |string|
    letters = string.split('')

    stripped_string =  letters.select { |letter| !VOWELS.include? letter }
    puts stripped_string.join("")
  end
end

strings = ["black", "white", "green", "yellow"]
strip_vowels(strings)