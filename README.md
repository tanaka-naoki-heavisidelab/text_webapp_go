- ubuntu で $ which go でパスが見つかる前提。
- プロジェクトのルートで
  $ go mod int <module-name>
  ここで <module-name> はあなたが選んだモジュール名で、通常は GitHub などのリポジトリの URL になります。例えば、github.com/yourusername/yourproject などです。
  go.mod が自動生成される。
- main.go を編集する。
- コンテナに Attach Shell を実行し、/home/appuser/bin に移動して./myapp を実行。

mysql フォルダ、mysql/data/db フォルダを root 権限ではなく、ユーザー権限で新設。
