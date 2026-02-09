class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'ユーザー登録が完了しました'
    else
      render :new
    end
  end

  # 以下の機能は管理者のみに限定する
  # before_actionを記述

  def index
    # 【実装課題】ユーザー一覧機能を実装してください
    #
    # 実装の流れ（考え方のヒント）：
    #
    # 1. 一覧画面に表示するユーザー情報を取得する
    #
    # 2. 表示件数が多くなることを想定し、
    #    ページごとに分けて表示できるようにする（1ページ10件）
    #
    # 3. 現在表示するページ番号は、
    #    リクエストパラメータから取得する
    #
    # 4. 1ページあたりの表示件数を決める
    #
    # ※ ページネーションを使わない場合は、
    #   並び順を意識して一覧を取得してみましょう
  end

  def destroy
    # 【実装課題】ユーザー削除機能を実装してください
    #
    # 実装の流れ（考え方のヒント）：
    #
    # 1. URLから渡される情報を使って、
    #    削除対象のユーザーを特定する
    #
    # 2. ユーザー情報を削除する
    #
    # 3. 一覧画面へ移動し、
    #    「ユーザーを削除しました」という削除完了のメッセージを表示する
    #
    # ※ 削除前の確認ダイアログは
    #   コントローラではなくビュー側で実装します
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
