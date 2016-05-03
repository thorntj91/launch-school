def fizzbuzz(first, last)
  #is n divisible by 3? -> print fizz
  #is n divisible by 5? -> print buzz
  #is n divisible by 3 and 5? then print fizzbuzz
  (first..last).each do |n|
    x1 = n % 3 == 0
    x2 = n % 5 == 0 

    case 
    when (x1 and x2) then puts "fizzbuzz"
    when x1 then puts "fizz"
    when x2 then puts "buzz"
    else
      puts n 
    end
  end
end

fizzbuzz(1, 50)

