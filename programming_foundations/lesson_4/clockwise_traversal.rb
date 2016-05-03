require 'pry'

array = [ [1,  2,  3,  4,  5 ],
          [6,  7,  8,  9,  10],
          [11, 12, 13, 14, 15],
          [16, 17, 18, 19, 20],
          [21, 22, 23, 24, 25]
        ]

# Slice from vertex D
def slice_from_D(arr, reduction)
  n = arr.length
  result = [[]]
  arr.each_with_index do |row, i|
    row.each_with_index do |cell, j|
      if j >= 0 and j < (n - reduction) and i >= reduction and i < n
        result << [] if result[i - reduction].nil?
        result[i - reduction] << cell
      end
    end
  end
  result
end

# Slice from vertex B
def slice_from_B(arr, reduction)
  n = arr.length
  result = [[]]
  arr.each_with_index do |row, i|
    row.each_with_index do |cell, j|
      if j >= reduction and j < n and i >= 0 and i < (n - reduction)
        result << [] if result[i].nil?
        result[i] << cell
      end
    end
  end
  result
end

def extract_mxm(arr, m, dir)
  n = arr.length
  return arr if m >= n
  
  reduction = n - m  
  case dir 
  when "L"
    result = slice_from_D(arr, reduction)
  when "R"
    result = slice_from_B(arr, reduction)
  else
    return arr
  end
  result
end

def traverse_TR_edges(arr)
  n = arr.length
  return arr if n < 2 

  result = []
  result << arr[0]

  arr.each_with_index do |row, i|
    if i > 0
      result << arr[i][n - 1] 
    end
  end
  result.flatten!
end


def traverse_BL_edges(arr)
  n = arr.length
  result = []

  result << arr[n - 1].reverse
  arr.to_enum.with_index.reverse_each do |row, i|
    if i < (n - 1)
      result << arr[i][0]
    end
  end
  result.flatten!
end

def clockwise_traversal(arr, depth=0)
  n = arr.length
  direction = ""
  depth % 2 == 0 ? direction = "R" : direction = "L" 
  result = []

  return [] if n < 0
  return arr[0] if n == 1
  
  case direction
  when "R"
    # Traverse top - right edges then slice sub-array along same edges
    result += traverse_TR_edges(arr)
    sub_array = extract_mxm(arr, n-1, "L")
    result += clockwise_traversal(sub_array, depth + 1)
  when "L"
    # Traverse bottom - left edges then slice sub-array along same edges
    result += traverse_BL_edges(arr)
    sub_array = extract_mxm(arr, n-1, "R")
    result += clockwise_traversal(sub_array, depth + 1)
  end

  result 
end 

p clockwise_traversal(array)
p clockwise_traversal(array2)








