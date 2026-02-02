# config/routes.rb
Rails.application.routes.draw do
  root 'home#index'
  
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  
  # 【実装課題】ログイン機能のルートを有効化してください
  # 以下のコメントを外して、ログイン機能を有効にしてください
  # get 'login', to: 'sessions#new'        # ログイン画面を表示
  # post 'login', to: 'sessions#create'    # ログイン処理を実行

  # 【実装課題】ログアウト機能のルートを有効化してください
  # 以下のコメントを外して、ログアウト機能を有効にしてください
  # delete 'logout', to: 'sessions#destroy'  # ログアウト処理を実行
  # ユーザー一覧画面(ログイン成功→ユーザー一覧へ遷移できるように設定)
  get 'users', to: 'users#index'

end