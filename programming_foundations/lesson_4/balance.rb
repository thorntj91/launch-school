require 'pry'
test1 = "hi"
test2 = "(hi"
test3 = "(hi)"
test4 = ")hi("

#count each ( and ) and make a note of them

def bracket_parity(string)
  return false unless string.count("(") == string.count(")")
  split_string = string.split("")
  previous = ""
  current = ""
  split_string.each do |c|
    if c == "(" || c == ")"
      previous = current
      current = c
    end
    binding.pry
    return false if current = "(" && previous == ")"
  end
  true
end


puts bracket_parity(test4)
