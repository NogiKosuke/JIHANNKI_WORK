# 在庫データを保存する

str = {:coke=>{:price=>120, :stock=>5}, :water=>{:price=>100, :stock=>5}, :redbull=>{:price=>200, :stock=>5}}

f = File.open("nogi_stock3.txt","w")

f.puts str

f.close