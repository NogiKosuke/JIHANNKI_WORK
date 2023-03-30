・workspace　配下で実施する(初回のみ)
git clone git@github.com:NogiKosuke/JIHANNKI_WORK.git

cd JIHA

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
