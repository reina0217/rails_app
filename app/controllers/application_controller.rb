# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  # current_userメソッドをビューでも使えるようにする
  helper_method :current_user
  
  private
  
  # 現在ログインしているユーザーを取得するメソッド
  # セッションに保存されたuser_idからユーザーを検索します
  # このメソッドは既に実装済みです（変更不要）
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end