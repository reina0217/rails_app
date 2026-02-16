require 'rails_helper'

RSpec.describe "Users", type: :request do
  #
  # 【実装課題】
  # ユーザー管理機能（一覧・削除）が完成したら、
  # 以下のテストを自分で実装してください。
  #
  # --------------------------------------------------
  # ヒント①
  # ユーザー削除機能のテスト
  #
  # - DELETE /users/:id にリクエストを送る
  # - ユーザーが1件削除されることを確認
  # - 削除後、ユーザー一覧画面にリダイレクトされることを確認
  #
  # describe "DELETE /users/:id" do
  #
  #   # 削除対象となるユーザーを用意する
  #   # let!(:user) do
  #   #   # ユーザー作成処理を書く
  #   # end
  #
  #   it "ユーザーを削除できること" do
  #     # delete リクエストを送信する
  #
  #     # User の件数が 1 減ることを確認
  #
  #     # レスポンスがリダイレクトであることを確認
  #
  #     # リダイレクト後の画面に
  #     # 「ユーザー一覧」などの文言が含まれていることを確認
  #   end
  # end
  #
  # --------------------------------------------------
  # ヒント②
  # ユーザー一覧機能のテスト
  #
  # - GET /users で一覧画面を表示
  # - ページネーションが正しく動作しているかを確認
  #
  # describe "GET /users" do
  #
  #   # before do
  #   #   複数のユーザーを作成する
  #   #   （例：15件程度）
  #   # end
  #
  #   it "1ページ目に指定件数のユーザーが表示されること" do
  #     # page=1 を指定してリクエストする
  #
  #     # 1ページ目に表示されるユーザーの email が
  #     # 含まれていることを確認
  #
  #     # 2ページ目に表示されるはずのユーザーが
  #     # 含まれていないことを確認
  #   end
  #
  #   it "2ページ目に残りのユーザーが表示されること" do
  #     # page=2 を指定してリクエストする
  #
  #     # 2ページ目に表示されるユーザーの email が
  #     # 含まれていることを確認
  #
  #     # 1ページ目のユーザーが
  #     # 含まれていないことを確認
  #   end
  # end
  describe "DELETE /users/:id" do
  
    # 削除対象となるユーザーを用意する
    let!(:user) do
      # ユーザー作成処理を書く
      # 管理者ユーザーと削除対象ユーザーを作成
      User.create(
        email: 'test@example.com',
        password: 'password',
        admin: true
      )
      User.create(
        email: 'deleteTest@example.com',
        password: 'password',
        admin: false
      )
    end

    # 管理者でログインする
    before do
      post login_path, params: {
        session: { email: 'test@example.com', password: 'password'}
      }
    end
  
    it "ユーザーを削除できること" do
      expect_count = User.count - 1

      # delete リクエストを送信する
      target_user = User.find_by(email: 'deleteTest@example.com')
      delete user_path(target_user)
  
      # User の件数が 1 減ることを確認
      expect(User.count).to eq(expect_count)
  
      # レスポンスがリダイレクトであることを確認
      expect(response).to redirect_to(users_path)
  
      # リダイレクト後の画面に
      # 「ユーザー一覧」などの文言が含まれていることを確認
      follow_redirect!
      expect(response.body).to include("ユーザーを削除しました")
    end
  end

  describe "GET /users" do

    let!(:user) do
      # 複数のユーザーを作成する
      # （例：15件程度）
      User.create(
        email: 'test@example.com',
        password: 'password',
        admin: true
      )

      15.times do |i|
        User.create(
          email: "user#{i + 1}@example.com",
          password: "password",
          admin: false
        )
      end
    end
  
    before do
      # 管理者でログインする
      post login_path, params: {
        session: { email: 'test@example.com', password: 'password'}
      }
    end
  
    it "1ページ目に指定件数のユーザーが表示されること" do
      # page=1 を指定してリクエストする
      get users_path, params: { page: 1 }
  
      # 1ページ目に表示されるユーザーの email が
      # 含まれていることを確認
      expect(response.body).to include("test@example.com")
      9.times do |i|
        expect(response.body).to include("user#{i + 1}@example.com")
      end
  
      # 2ページ目に表示されるはずのユーザーが
      # 含まれていないことを確認
      6.times do |i|
        expect(response.body).not_to include("user#{i + 10}@example.com")
      end
    end
  
    it "2ページ目に残りのユーザーが表示されること" do
      # page=2 を指定してリクエストする
      get users_path, params: { page: 2 }
  
      # 2ページ目に表示されるユーザーの email が
      # 含まれていることを確認
      6.times do |i|
        expect(response.body).to include("user#{i + 10}@example.com")
      end
  
      # 1ページ目のユーザーが
      # 含まれていないことを確認
      expect(response.body).not_to include("test@example.com")
      9.times do |i|
        expect(response.body).not_to include("user#{i + 1}@example.com")
      end
    end
  end
end
