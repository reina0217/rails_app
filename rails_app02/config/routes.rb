# config/routes.rb
Rails.application.routes.draw do
  root 'home#index'
  
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'

  # ログアウト用
  delete 'logout', to: 'sessions#destroy'

  # 【実装課題】ユーザー管理機能のルートを有効化してください
  # 以下のコメントを外して、ユーザー一覧と削除機能を有効にしてください
  resources :users, only: [:new, :create, :index, :destroy]
end