class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # 【実装課題】ログイン機能を実装したら、以下のコメントを外してください
      # ユーザー登録成功時に自動的にログイン状態にする処理です
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'ユーザー登録が完了しました'
    else
      render :new
    end
  end

  def index
    @users = User.all
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end 