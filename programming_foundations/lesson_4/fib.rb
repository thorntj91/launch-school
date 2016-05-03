#fibonacci number if n = n-2 + n-1
def is_perfect_sq?(n)
  root = Math.sqrt(n)  
  return true if root % 1 == 0 
  false
end

def is_fib?(number)
 sq1 = (5 * (number**2) + 4)
 sq2 = (5 * (number**2) - 4)

 return true if is_perfect_sq?(sq1) || is_perfect_sq?(sq2)
 false
end

array = [1,2,3,4,5,6,7,8,9,10]

fib_index = []

array.each_with_index do |ele, idx|
  fib_index << ele if is_fib?(idx)
end

p fib_index


