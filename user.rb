# class User
#   attr_accessor :slot_money

#   def initialize
#     @slot_money = 0
#   end

#   def slot_money_to_vm(money)
#     # 想定外のもの（１円玉や５円玉。千円札以外のお札、そもそもお金じゃないもの（数字以外のもの）など）
#     # が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
#     return false unless VendingMachine::MONEY.include?(money)
#     # 自動販売機にお金を入れる
#     @slot_money += money
#   end
# end