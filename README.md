・workspace　配下で実施する(初回のみ)
git clone git@github.com:NogiKosuke/JIHANNKI_WORK.git

cd JIHA

・masterブランチに移動する
git checkout master

・リモートリポジトリでmasterブランチの更新があるか確認する（必ず実行すること！！！）
git pull

・ブランチを切る
git checkout -b dev
このコマンドでは以下の２つの動作を実行します。

devブランチを作る
devブランチに移動する

〜〜ここから編集を行う〜〜



〜〜以下は編集終了後に行う〜〜

・変更点をローカルリポジトリでコミットする
git add .
git commit -m ""

・リモートリポジトリへpushする
git push origin dev

ステップ２　ジュースの管理
値段と名前の属性からなるジュースを１種類格納できる。初期状態で、コーラ（値段:120円、名前”コーラ”）を5本格納している。
格納されているジュースの情報（値段と名前と在庫）を取得できる。
注意：責務を持ちすぎていませんか？責任を持ちすぎていたら分割しましょう



ステップ３　購入
OK 投入金額、在庫の点で、コーラが購入できるかどうかを取得できる。 
OK ジュース値段以上の投入金額が投入されている条件下で購入操作を行うと、ジュースの在庫を減らし、売り上げ金額を増やす。
OK 投入金額が足りない場合もしくは在庫がない場合、購入操作を行っても何もしない。
現在の売上金額を取得できる。
払い戻し操作では現在の投入金額からジュース購入金額を引いた釣り銭を出力する。
注意：責務が集中していませんか？責務が多すぎると思ったら分けてみましょう



irb
require '/home/user/workspace/JIHANNKI_WORK/work.rb'
 moe = VendingMachine.new
 moe.check_buy('coke')
  moe.slot_money(1000)
  moe.current_slot_money

require'/Users/user/workspace/JIHANNKI_WORK/work.rb'