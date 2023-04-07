

# # puts juice_hash

# # puts juice_hash[:coke][:price]
# # puts juice_hash[:coke][:stock]

# def stock_juice(name, price, stock)
#   juice_hash = {coke: {price: 120, stock: 5}, water: {price: 100, stock: 3}}
#   puts test = {"#{name}": {price: price, stock: stock}}
#   puts juice_hash
#   # juice_hash << {"#{name}": {price: price, stock: stock}}
#   juice_hash.store(name.to_sym, {price: price, stock: stock})
#   puts juice_hash
#   puts juice_hash[name.to_sym][:price]
#   puts juice_hash[name.to_sym][:stock]
# end

# stock_juice("redbull", "200", "5")

def get_purchaseable
  h = {coke: {price: 120, stock: 5}, water: {price: 100, stock: 3}}
  money = 110
  puts "購入できる商品は以下の通り"

  h.each do |name, hash|
    # if h[:coke][:stock] >= 1 && h[:coke][:price] <= money  
    # if h[:water][:stock] >= 1 && h[:water][:price] <= money  
    # puts "#{name}"
    # puts "#{hash}"
    # hash = {:price=>120, :stock=>5}
    if hash[:price]<=money && hash[:stock]>=1
      puts "#{name}"
    end
  end
end

get_purchaseable
# def get_all_beverages 
#   @beverage.each do |name, hash|
#     puts "ジュース名： #{name}, 値段: #{hash[:price]}, 在庫数:  #{hash[:stock]}"
#   end
# end

# # >= 1 && juice_hash["#{name}"][:price] <= @slot_money

# name = "coke"
# puts "#{name.to_sym}"

# puts juice_hash[name.to_sym]

# if juice_hash[name.to_sym][:stock] >= 1 && juice_hash[name.to_sym][:price] <= @slot_money
#   puts "買えるよ！"
# end

# stock_juice("ocha", 120, 2)

# drink ={coke: {price: 120, stock: 5}, water: {price: 100, stock: 5}}
# puts drink[:water][:price]
