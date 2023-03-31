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