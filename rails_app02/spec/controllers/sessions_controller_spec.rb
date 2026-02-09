require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let(:user) { User.create(email: "test@example.com", password: "password") }

  describe "POST /login" do
    context "ログイン成功時" do
      it "トップページにリダイレクトされ、通知が表示される" do
        post login_path, params: { session: { email: user.email, password: "password" } }
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include("ログインしました")
      end
    end

    context "ログイン失敗時" do
      it "エラーメッセージが表示され、422を返す" do
        post login_path, params: { session: { email: user.email, password: "wrongpassword" } }
        expect(response).to have_http_status(422)
        expect(response.body).to include("メールアドレスまたはパスワードが正しくありません")
      end
    end
  end

  describe "DELETE /logout" do
    before do
      post login_path, params: { session: { email: user.email, password: "password" } }
    end

    it "ログアウトされ、トップページにリダイレクトされる" do
      expect(session[:user_id]).to eq(user.id)

      delete logout_path

      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include("ログアウトしました")
    end
  end
end
