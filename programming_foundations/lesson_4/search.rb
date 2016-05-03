ARR = [{name: "Item", price: 230 }, {name: "Item", price: 300}, {name: "Item 2", price: 500}]

query = {
  min: 200,
  max: 350,
  name: "Item"
}

query2 = {
  min: 200,
  max: 600,
  name: "Item 2"
}


def search(query)
  ARR.select do |hash| 
    hash if hash[:price].between?(query[:min], query[:max]) && hash[:name] == query[:name]
  end
end

p search(query)
puts " "
p search(query2)