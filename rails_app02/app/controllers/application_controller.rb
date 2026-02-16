# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  helper_method :current_user
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # 管理者権限のあるユーザー以外はアクセスできないよう制御する(TOPにとどまり、エラー表示)
  def require_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "権限がありません"
    end
  end
end

