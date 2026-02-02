require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  # 【実装課題】ログイン機能を実装したら、以下のテストを有効化してください
  # 
  # 実装のヒント：
  # 1. ログイン画面が表示できるかテスト
  # 2. ログイン処理が正常に動作するかテスト
  # 3. ログアウト処理が正常に動作するかテスト
  # 
  # テストの例：
  # test "should get new" do
  #   get login_path
  #   assert_response :success
  # end
  #
  # test "should login with valid credentials" do
  #   user = users(:one)  # fixturesからユーザーを取得
  #   post login_path, params: { session: { email: user.email, password: "password" } }
  #   assert_redirected_to root_path
  #   assert_equal user.id, session[:user_id]
  # end
  #
  # test "should logout" do
  #   delete logout_path
  #   assert_redirected_to root_path
  #   assert_nil session[:user_id]
  # end
end
