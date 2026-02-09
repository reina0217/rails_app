require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  #
  # 【実装課題】
  # ログイン・ログアウト機能が完成したら、
  # 以下のテストを自分で実装してください。
  #
  # --------------------------------------------------
  # ヒント①
  # テスト用のユーザーを用意しましょう。
  # - let を使う
  # - email と password を設定する
  #
  # let(:user) do
  #   # ここにユーザー作成処理を書く
  # end
  #
  # --------------------------------------------------
  # ヒント②
  # POST /login でログイン処理をテストします
  #
  # describe "POST /login" do
  #
  #   context "ログイン成功時" do
  #     it "ログイン後、トップページへリダイレクトされる" do
  #       # 正しい email / password を送信する
  #
  #       # response が root_path にリダイレクトされていることを確認
  #
  #       # リダイレクト後の画面に
  #       # 「ログインしました」という文言が含まれていることを確認
  #     end
  #   end
  #
  #   context "ログイン失敗時" do
  #     it "エラーメッセージが表示される" do
  #       # 間違った password を送信する
  #
  #       # ステータスコードが 422 であることを確認
  #
  #       # レスポンスにエラーメッセージが含まれていることを確認
  #     end
  #   end
  # end
  #
  # --------------------------------------------------
  # ヒント③
  # DELETE /logout でログアウト処理をテストします
  #
  # describe "DELETE /logout" do
  #
  #   # 事前にログイン状態を作っておきましょう
  #   # before do
  #   #   # ログイン処理を書く
  #   # end
  #
  #   it "ログアウトされ、トップページへリダイレクトされる" do
  #     # ログイン中は session[:user_id] が存在することを確認
  #
  #     # logout を実行する
  #
  #     # session[:user_id] が nil になっていることを確認
  #
  #     # root_path にリダイレクトされていることを確認
  #
  #     # リダイレクト後の画面に
  #     # 「ログアウトしました」という文言が含まれていることを確認
  #   end
  # end
  let!(:user) do
    # ここにユーザー作成処理を書く
    User.create(
      email: 'test@example.com',
      password: 'password',
    )
  end
  describe "POST /login" do
  
    context "ログイン成功時" do
      it "ログイン後、トップページへリダイレクトされる" do
        # 正しい email / password を送信する
        post login_path, params:{ session: {email:'test@example.com', password: 'password'}}
  
        # response が root_path にリダイレクトされていることを確認
        expect(response).to redirect_to(root_path)
  
        # リダイレクト後の画面に
        # 「ログインしました」という文言が含まれていることを確認
        follow_redirect!
        expect(response.body).to include("ログインしました")
      end
    end
  
    context "ログイン失敗時" do
      it "エラーメッセージが表示される" do
        # 間違った password を送信する
        post login_path, params:{ session: {email:'mistake@example.com', password: 'mistake'}}
  
        # ステータスコードが 422 であることを確認
        expect(response).to have_http_status(:unprocessable_entity)
  
        # レスポンスにエラーメッセージが含まれていることを確認
        expect(response.body).to include("メールアドレスまたはパスワードが正しくありません")
      end
    end
  end
end
