# Rails アプリケーション開発カリキュラム

## 環境構築

### 前提条件

- Docker Desktop がインストールされていること
- Git がインストールされていること

### セットアップ手順

1. イメージをビルド

```bash
docker-compose build --no-cache
```

2. 必要な gem のインストール

```bash
docker-compose run --rm web bundle install
```

3. データベースの作成

```bash
docker-compose run --rm web rails db:create
docker-compose run --rm web rails db:migrate
```

4. テストユーザーの作成

```bash
# Railsコンソールを起動
docker-compose run --rm web rails console

# コンソール内で以下のコマンドを実行
User.create(
  email: 'test@example.com',
  password: 'password',
)

# コンソールを終了
exit
```

5. テストユーザーの削除（必要に応じて）

```bash
# Railsコンソールを起動
docker-compose run --rm web rails console

# 削除したいユーザーを検索
user = User.find_by(email: 'test@example.com')

# 検索したユーザーを削除
user.destroy

# 削除が成功したか確認。nilが返ってきたらOK！
User.find_by(email: 'test@example.com')
# => nil

# コンソールを終了
exit
```

6. サーバーの起動

```bash
docker-compose up
```

7. ブラウザで確認

```bash
http://localhost:3000 にアクセス
```

8. テスト実行

```bash
docker-compose run --rm web rspec spec/フォルダ名/ファイル名
```

## テストユーザーの情報

- メールアドレス: test@example.com
- パスワード: password

## 実装課題：ログイン機能

このアプリケーションでは、ログイン機能とログアウト機能が未実装の状態になっています。
以下の順序で実装を進めてください。

### 実装の順序

1. **ルートの設定** (`config/routes.rb`)
   - ログイン画面、ログイン処理、ログアウト処理のルートを有効化

2. **ログイン画面の作成** (`app/views/sessions/new.html.erb`)
   - ログインフォームを実装（emailとpasswordの入力フィールド）

3. **ログイン処理の実装** (`app/controllers/sessions_controller.rb`)
   - `create` メソッドでログイン処理を実装
   - ユーザー認証とセッション管理

4. **ログアウト処理の実装** (`app/controllers/sessions_controller.rb`)
   - `destroy` メソッドでログアウト処理を実装

5. **ビューの有効化**
   - `app/views/layouts/application.html.erb` のログイン/ログアウトリンクを有効化
   - `app/views/home/index.html.erb` のログインリンクを有効化

6. **自動ログイン機能** (`app/controllers/users_controller.rb`)
   - ユーザー登録成功時に自動ログインする処理を追加

7. **テストの実装** ※ここは課題2回目の内容です。
   -  `spec/controllers/sessions_controller_spec.rb` にテストを追加

### 実装のヒント

各ファイルには実装のヒントがコメントとして記載されています。
分からない場合は、コメントを参考にしながら実装を進めてください。

### 参考資料

- [Rails ガイド](https://railsguides.jp/)
- [Bootstrap 公式ドキュメント](https://getbootstrap.com/docs/5.3/getting-started/introduction/)
