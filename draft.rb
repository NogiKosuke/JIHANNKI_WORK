juice_hash = {coke: {price: 120, stock: 5}, water: {price: 100, stock: 3}}

puts juice_hash


puts juice_hash[:coke][:price]
puts juice_hash[:coke][:stock]

def stock_juice (name, price, stock)
  puts test = {"#{name}": {price: price, stock: stock}}
  puts juice_hash
  juice_hash << {"#{name}": {price: price, stock: stock}}
  puts juice_hash
  puts juice_hash[:name][:price]
  puts juice_hash[:name][:stock]
end

# stock_juice("ocha", 120, 2)

puts "=========="
juice_hash.each do |key, hash| 
# puts key
# puts hash[:price]
# puts hash[:stock]
puts "ジュース名： #{key}, 値段: #{hash[:price]}, 在庫数:  #{hash[:stock]}"
end