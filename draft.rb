juice_hash = {coke: {price: 120, stock: 5}, water: {price: 100, stock: 3}}

# puts juice_hash

# puts juice_hash[:coke][:price]
# puts juice_hash[:coke][:stock]

def stock_juice (name, price, stock)
  puts test = {"#{name}": {price: price, stock: stock}}
  puts juice_hash
  juice_hash << {"#{name}": {price: price, stock: stock}}
  puts juice_hash
  puts juice_hash[:name][:price]
  puts juice_hash[:name][:stock]
end




# >= 1 && juice_hash["#{name}"][:price] <= @slot_money

name = "coke"
puts "#{name.to_sym}"

puts juice_hash[name.to_sym]

if juice_hash[name.to_sym][:stock] >= 1 && juice_hash[name.to_sym][:price] <= @slot_money
  puts "買えるよ！"
end

# stock_juice("ocha", 120, 2)