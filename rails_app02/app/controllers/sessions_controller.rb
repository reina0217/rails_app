class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'ログインしました'
    else
      flash.now[:alert] = 'メールアドレスまたはパスワードが正しくありません'
      render :new,status: :unprocessable_entity
    end
  end

  # ログアウトした後
  def destroy
    reset_session
    redirect_to root_path, notice: 'ログアウトしました'
  end
end