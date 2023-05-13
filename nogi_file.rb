現在使われているハッシュ記法を文字列として呼び出してJSONのデータ構造を利用してハッシュに変換する
require 'json'
file = File.open("nogi_stock.txt", "r")
str = file.read

str = str.gsub(/(\w+):/) do
      "\"#{$1}\":"
     end
puts str

hash = JSON.parse(str, symbolize_names: true)

puts hash

puts hash
puts hash[:coke]
