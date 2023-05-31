- ubuntu で $ which go でパスが見つかる前提。
- main.go を編集する。
- main.go に必要なライブラリ等を build.sh に記入。
  MODULE_NAME=$(basename $(pwd)) #アプリフォルダ名
  go mod init $MODULE_NAME #go.mod 生成
  go get github.com/joho/godotenv #必要なライブラリ 　
  mkdir -p bin/
  CGO_ENABLED=0 GOOS=linux go build -v -o bin/myapp
- app コンテナを起動し、右クリック →Attach Shell でコンテナ内に入る。
- /home/appuser/app/MODULE_NAME に移動。
- ./build.sh を実行すると bin フォルダに myapp が生成され、localhost に取り出される。
- go のバージョン 1.17 まで、実行環境の監視は 1 アプリケーションだったらしいが、go.work に登録することで監視対象のアプリケーションフォルダを増やせるらしい。1.20 から directory から use に変わっている。
  go work init ./app_cmdswitch ./app_hello ./app_mysqltest
