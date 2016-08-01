def select(array)
  counter = 0
  result = []
  while counter < array.length
    result << array[counter] if yield(array[counter])
    counter += 1
  end
  result
end

array = [1, 2, 3, 4, 5]

select(array) { |num| num.odd? }
select(array) { |num| puts num }
select(array) { |num| num + 1 }  