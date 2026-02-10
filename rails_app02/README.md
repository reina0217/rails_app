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
  admin: true
)

# コンソール内で以下のコマンドを実行
50.times do |i|
  User.create(
    email: "user#{i + 1}@example.com",
    password: "password",
    admin: false
  )
end

# コンソールを終了
exit
```

5. テストユーザーの削除(必要に応じて)

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

## 実装課題：ユーザー管理画面

このアプリケーションでは、ユーザー管理画面（一覧表示・削除機能）が未実装の状態になっています。
以下の順序で実装を進めてください。

### 実装の順序

1. **ルートの設定** (`config/routes.rb`)
   - ユーザー一覧画面と削除処理のルートを有効化
   - `resources :users, only: [:index, :destroy]` または個別にルートを定義

2. **ユーザー一覧機能の実装** (`app/controllers/users_controller.rb`)
   - `index` メソッドでユーザー一覧を取得
   - ページネーション機能を実装（kaminari gemを使用）

3. **ユーザー一覧画面の作成** (`app/views/users/index.html.erb`,`application_controller.rb`,`users_controller.rb`)
   - テーブルでユーザー情報を表示
   - 削除ボタンを追加 ※自身のデータ欄には表示させない
   - ページネーション機能を追加
   - 管理者以外はアクセスできないよう制御

4. **ユーザー削除機能の実装** (`app/controllers/users_controller.rb`)
   - `destroy` メソッドでユーザー削除処理を実装
   - 削除後にユーザー一覧画面にリダイレクト

5. **ナビゲーションバーの有効化** (`app/views/layouts/application.html.erb`)
   - ユーザー一覧へのリンクを有効化

6. **テストの実装** (`spec/controllers/user_controller_spec.rb`)
   - ユーザー一覧機能のテスト
   - ユーザー削除機能のテスト
   - ページネーション機能のテスト

### 実装のヒント

各ファイルには実装のヒントがコメントとして記載されています。
分からない場合は、コメントを参考にしながら実装を進めてください。

### 必要な知識

- Rails のルーティング（resources）
- コントローラーのアクション（index, destroy）
- ビューテンプレート（ERB）
- ページネーション（kaminari gem）
- リンクヘルパー（link_to）
- HTTPメソッド（GET, DELETE）

### 参考資料

- [Rails ガイド](https://railsguides.jp/)
- [Bootstrap 公式ドキュメント](https://getbootstrap.com/docs/5.3/getting-started/introduction/)
- [kaminari gem ドキュメント](https://github.com/kaminari/kaminari)
