class VendingMachine
  require 'json'
  # ステップ０　お金の投入と払い戻しの例コード
  # ステップ１　扱えないお金の例コード
  # NOGIT IS COOL
  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  #beautiful moe
  MONEY = [10, 50, 100, 500, 1000].freeze
  STOCK_FILE = "nogi_stock.txt"
  SALE_AMOUNT_FILE = "nogi_sale_amount.txt"
  HIT_AMOUNT_FILE = "nogi_hit_amount.txt"

  attr_accessor :slot_money, :hit_flag, :sale_amount, :hit_amount

  # （自動販売機に投入された金額をインスタンス変数の @slot_money に代入する）
  def initialize
    # 最初の自動販売機に入っている金額は0円
    @slot_money = 0
    # 最初の自販機に入っているのは１２０円のコーラ５本
    unless read_stock
      @beverage = {
                    :coke=>{:price=>120, :stock=>5},
                    :water=>{:price=>100, :stock=>5},
                    :redbull=>{:price=>200, :stock=>5}
                  }
    else
      read_stock
    end
    # 最初の売上金額は０円
    @sale_amount = 0
    @hit_flag = false
    @hit_amount = 0
  end

  def read_stock 
    unless File.exist?(STOCK_FILE)
      return false
    else
      file = File.open(STOCK_FILE, "r")
      str = file.read
      str = str.gsub(/:(\w+)=>/)do
          "\"#{$1}\": "
      end
      @beverage = JSON.parse(str, symbolize_names: true)
    end
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
  def update_beverages(name, price, stock)
    @beverage.store(name.to_sym, {price: price, stock: stock})
  end
  
  # 投入金額、在庫の点で購入可能なドリンクのリストを取得できる。
  def get_purchaseable
    puts "購入できる商品は以下の通り"
    unless @hit_flag
      @beverage.each do |name, hash|
        if hash[:price]<=@slot_money && hash[:stock]>=1
          puts "#{name}"
        end
      end
    else
      @beverage.each do |name, hash|
        if hash[:stock]>=1
          puts "#{name}"
        end
      end
    end
  end
  
  def check_buy(name)
    unless @beverage.has_key?(name.to_sym)
      puts "その商品はありません"
      return false
    end
    unless @hit_flag
      if @beverage[name.to_sym][:stock] >= 1 && @beverage[name.to_sym][:price] <= slot_money
        puts "買えるよ！"
        true
      else
        puts "買えないよ！"
        false
      end
    else
      if @beverage[name.to_sym][:stock] >= 1
        puts "買えるよ！"
        true
      else
        puts "買えないよ！"
        false
      end
    end
  end
  
  def buy(name)
    if check_buy(name)
      @beverage[name.to_sym][:stock] -= 1
      @sale_amount += @beverage[name.to_sym][:price]
      if @hit_flag
        @hit_amount += @beverage[name.to_sym][:price]
      end
      true
    end
  end

  def get_sale_amount
    @sale_amount
  end

  def hit
    @hit_flag = false
    @rand_num = rand(1..3)
  end

  def display_hit(rand_num)
    if rand_num == 1
      print "7"
      sleep 1.5
      print "7"
      sleep 2
      puts "7"
      sleep 0.5
      puts "当たり！"
      @hit_flag = true
    else
      print "7"
      sleep 1.5
      print "7"
      sleep 2
      puts "#{rand(1..6)}"
      sleep 0.5
      puts "はずれ！"
    end
  end

  def save_stock
    f = File.open(STOCK_FILE,"w")
    f.puts @beverage
    f.close
  end

  def save_amount(fine_name, amount)
    if File.exist?(fine_name)
      f = File.open(fine_name,"r")
      amount += f.read.chomp.to_i
    end
    f = File.open(fine_name,"w")
    f.puts amount
    f.close
  end
end

class Boot

  # 数値の種類が増えると意味が分かりづらくなるので、定数として名前をつけておく
  MENU_INSERT_MONEY = 1
  MENU_BUY = 2
  MENU_RETURN_MONEY = 3
  MENU_ADMIN = 23031107
  VALID_MENU_NUMBER = [
    MENU_INSERT_MONEY,
    MENU_BUY,
    MENU_RETURN_MONEY,
    MENU_ADMIN
  ].freeze
  
  def self.vending_machine
    vm = VendingMachine.new

    # 個人敵に、Bootクラスに書いてある実装は全てVendingMachineクラスの実装とした方が良いかなと思います。
    # 人の動きをイメージすると、Bootの処理（お金を入れる、飲み物を選択する）をVendingMachineとは別クラスに書くことも想像できますが、
    # 今のプログラム的には結局VendingMachineの処理を呼び出しているだけなので、全てVendingMachineにまとめられそうです。

    # 例えばここで
    # vm.start
    # とすると、VendingMachineのstartメソッド内で
    #
    # while true
    #   ...
    #
    # と、今Bootクラスでやっている処理が全て動くようなイメージです。

    while true
      menu_number = get_menu_number

      # ガード句で異常な値を先にチェックする
      unless VALID_MENU_NUMBER.include?(menu_number)
        puts "１〜３の数字を入力してください"
        next
      end

      # ここのwhileループは処理の分岐だけを担うようにして、具体的な表示やデータの処理は別メソッドに切り出しています。
      # こうすると
      # 「自販機のメニューを増やす（分岐を増やす）際は、このwhileループを修正して新しいメソッドを足す」
      #  「今あるメニューの機能を拡張したい場合は、個別のメニュー用のメソッドを中身だけ改修する。このwhileループは触らない」
      # となり、今後の改修時に気にするべきコードが限定されて改修しやすくなります。
      case menu_number
      when MENU_INSERT_MONEY
        insert_money(vm)
      when MENU_BUY
        buy(vm)
      when MENU_RETURN_MONEY
        return_money(vm)
        break
      when MENU_ADMIN
        perform_admin_function(vm)
      end
    end
  end

  def get_menu_number
    puts "いらっしゃいませ　メニュー番号(1から3)を入力してください"
    puts "1:お金を入れる"
    puts "2:購入する"
    puts "3:終了する"
    gets.to_i
  end

  def insert_money(vm)
    puts "1:お金を入れる"
    puts "お金を入れてください　（一枚ずつ入れてください）"

    money = gets.to_i
    vm.slot_money_in(money)
    puts"現在の投入金額は#{vm.slot_money}円です。"
    puts "--------------------------------------------"
    vm.get_purchaseable
  end

  def buy
    raffle = false

    while true
      puts "購入したい商品を入力してください"

      # VendingMachineの中で今抽選に当たった状態かを判別するhit_flagを持っていますが、
      # 現状でhit_flagを利用しているのはget_purchaseableとcheck_buyぐらいのようなので、
      # このように引数で渡すパターンもありかな、と思いました。
      # ※なぜこれが「有り」と思うかは別でコメントを共有します。
      vm.get_purchaseable(raffle:)
      name = gets.chomp
  
      vm.buy(name, raffle:)

      # 抽選に当たる限り何度でも買えるようにする。
      # win_raffle?は、当たったらhit_flagを設定してtrue、外れたらfalseを返すメソッドのイメージ。
      #
      # 例えばこんな感じ。
      # def win_raffle?
      #   # rand_numは抽選時に決まればいいはずなので、インスタンス変数ではなく抽選時に算出する
      #   rand_num = (1..3)
      #   if rand_num == 1
      #     print "7"
      #     sleep 1.5
      #     print "7"
      #     sleep 2
      #     puts "7"
      #     sleep 0.5
      #     puts "当たり！"
      #
      #     @hit_flag = true
      #     true
      #   else
      #     print "7"
      #     sleep 1.5
      #     print "7"
      #     sleep 2
      #     puts "#{rand(1..6)}"
      #     sleep 0.5
      #     puts "はずれ！"
      #
      #     @hit_flag = false
      #     false
      #   end
      # end

      raffle = vm.win_raffle?
      break unless raffle
    end
  end

  def return_money(vm)
    vm.return_money
    puts "ありがとうございました　またのご利用をお待ちしております"

    # この辺りは、vmのメソッドでまとめられそうです。
    # 例えばこんな感じで書けると良いかなと思います。
    # vm.save_stock_and_amount
    # => save_stock_and_amountを呼び出すと、vmの中でsave_stockとsave_amountが呼び出されて保存されるイメージ

    vm.save_stock
    vm.save_amount(VendingMachine::SALE_AMOUNT_FILE, vm.sale_amount)
    vm.save_amount(VendingMachine::HIT_AMOUNT_FILE, vm.hit_amount)
  end

  def perform_admin_function
    while true

      # 管理者メニューも、通常の購入用メニューと一緒で、メニューの分岐だけのメソッドと、具体的な処理を行うメソッドに分けると良さそうです

      puts "管理者メニュー"
      puts "1:売上を見る"
      puts "2:在庫を確認する"
      puts "3:商品を更新する"
      puts "4:終了する"
      admin_number = gets.to_i
      if admin_number == 1
        puts "売上は#{vm.get_sale_amount}円です。"
      elsif admin_number == 2
        vm.get_all_beverages
      elsif admin_number == 3
        puts "商品を更新します。商品名を入力してください"
        name = gets.chomp
        puts "値段を入力してください"
        price = gets.chomp.to_i
        puts "在庫数を入力してください"
        stock = gets.chomp.to_i
        vm.update_beverages(name, price, stock)
        vm.get_all_beverages
      elsif admin_number == 4
        break
      end
    end
  end
end

Boot.vending_machine
