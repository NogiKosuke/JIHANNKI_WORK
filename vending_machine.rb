class VendingMachine
  # ステップ０　お金の投入と払い戻しの例コード
  # ステップ１　扱えないお金の例コード
  # NOGIT IS COOL
  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  #beautiful moe
  MONEY = [10, 50, 100, 500, 1000].freeze

  attr_accessor :slot_money

  # （自動販売機に投入された金額をインスタンス変数の @slot_money に代入する）
  def initialize
    # 最初の自動販売機に入っている金額は0円
    @slot_money = 0
    # 最初の自販機に入っているのは１２０円のコーラ５本
    @beverage = {coke: {price: 120, stock: 5},
                  water: {price: 100, stock: 5},
                  redbull: {price: 200, stock: 5}}
    # 最初の売上金額は０円
    @sale_amount = 0
  end

  # 投入金額の総計を取得できる。
  def current_slot_money
    # 自動販売機に入っているお金を表示する
    @slot_money
  end

  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  # 投入は複数回できる。
  def slot_money_in(money)
    # 想定外のもの（１円玉や５円玉。千円札以外のお札、そもそもお金じゃないもの（数字以外のもの）など）
    # が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
    return puts"失敗しました" unless MONEY.include?(money)
    # 自動販売機にお金を入れる
    @slot_money += money
  end

  # 払い戻し操作を行うと、投入金額の総計を釣り銭として出力する。
  def return_money
    # 返すお金の金額を表示する
    puts "#{@slot_money - @sale_amount}円返却しました"
    # 自動販売機に入っているお金を0円に戻す˝
    @slot_money = 0
  end

  # 格納されているジュースの情報を取得する
  def get_all_beverages 
    @beverage.each do |name, hash|
      puts "ジュース名： #{name}, 値段: #{hash[:price]}, 在庫数:  #{hash[:stock]}"
    end
  end

  #自動販売機にジュースを入れる
  def add_beverages(name, price, stock)
    @beverage.store(name.to_sym, {price: price, stock: stock})
  end
  
  # 投入金額、在庫の点で購入可能なドリンクのリストを取得できる。
  def get_purchaseable
    puts "購入できる商品は以下の通り"
    @beverage.each do |name, hash|
      if hash[:price]<=@slot_money && hash[:stock]>=1
        puts "#{name}"
      end
    end
  end
  
  def check_buy(name)
    if @beverage[name.to_sym][:stock] >= 1 && @beverage[name.to_sym][:price] <= slot_money
      puts "買えるよ！"
      true
    else
      puts "買えないよ！"
      false
    end
  end
  
  def buy(name)
    if check_buy(name)
      @beverage[name.to_sym][:stock] -= 1
      @sale_amount += @beverage[name.to_sym][:price]
      # puts @beverage[name.to_sym][:stock]
      # puts @sale_amount
    end
  end

  def get_sale_amount
    @sale_amount
  end
end

class Boot
  def self.vending_machine
    vm = VendingMachine.new
    while true
      puts "いらっしゃいませ　数字を入力してください"
      puts "1:お金を入れる"
      puts "2:購入する"
      puts "3:終了する"
      number = gets.to_i
      if number == 1
        puts "1:お金を入れる"
        puts "お金を入れてください　（一枚ずつ入れてください）"
          money = gets.to_i
          vm.slot_money_in(money)
          puts"現在の投入金額は#{vm.slot_money}円です。"
          puts "--------------------------------------------"
          vm.get_purchaseable
      elsif number == 2
        puts "購入したい商品を入力してください"
        vm.get_purchaseable
        name = gets.chomp
        vm.buy(name)
      elsif number == 3
        vm.return_money
        puts "ありがとうございました　またのご利用をお待ちしております"
        break
      elsif number == 23031107 
        while true
          puts "管理者メニュー"
          puts "1:売上を見る"
          puts "2:在庫を確認する"
          puts "3:商品を追加する"
          puts "4:終了する"
          admin_number = gets.to_i
          if admin_number == 1
            puts "売上は#{vm.get_sale_amount}円です。"
          elsif admin_number == 2
            vm.get_all_beverages
          elsif admin_number == 3
            puts "商品を更新します。商品名を入力してください"
            name = gets.chomp
          elsif admin_number == 4
            break
          end
        end
      else
        puts "１〜３の数字を入力してください"
      end
    end
  end
end

# Boot.vending_machine
