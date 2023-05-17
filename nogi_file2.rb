# 在庫データを文字列として受け取りそれをJSONのデータ構造を利用してJSONが求める形に変換してハッシュ化する
require 'json'
file = File.open("nogi_stock2.txt", "r")
str = file.read

puts str

str = str.gsub(/:(\w+)=>/)do
    "\"#{$1}\": "
end

puts str

hash = JSON.parse(str, symbolize_names: true)
puts hash [:coke]