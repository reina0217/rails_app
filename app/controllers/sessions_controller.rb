class SessionsController < ApplicationController
  def new
    # ログイン画面を表示するアクション
    # ビューを表示するだけのため、特別な処理は不要です
  end

  def create
    # 【実装課題】ログイン機能を実装してください
    #
    # 実装の流れ（考え方のヒント）：
    #
    # 1. フォームから送信された情報を受け取る
    #    ・メールアドレス
    #    ・パスワード
    #
    # 2. メールアドレスを使ってユーザーを探す
    #
    # 3. ユーザーが見つかり、かつパスワードが正しければログイン成功
    #
    # 4. ログイン成功時の処理
    #    ・ログイン状態をセッションに保存する
    #    ・トップページへ移動する
    #    ・「ログインしました」というメッセージを表示する
    #
    # 5. ログイン失敗時の処理
    #    ・「メールアドレスまたはパスワードが正しくありません」というエラーメッセージを表示する
    #    ・ログイン画面を再表示する
    #    ・ステータスコードを適切に設定する
    email = params[:session][:email]
    password = params[:session][:password]
    
    user = User.find_by(email: email)

    if user&.authenticate(password)
      session[:user_id] = user.id
      redirect_to root_path, notice: "ログインしました"
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが正しくありません"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    # 【実装課題】ログアウト機能を実装してください
    #
    # 実装の流れ（考え方のヒント）：
    #
    # 1. ログイン情報をセッションから削除する
    #
    # 2. トップページへ移動する
    #
    # 3. 「ログアウトしました」というメッセージを表示する
    session.delete(:user_id)
    redirect_to root_path, notice: "ログアウトしました"
  end
end
