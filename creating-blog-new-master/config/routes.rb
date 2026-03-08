Rails.application.routes.draw do
  root 'articles#index'

  devise_for :users, only: [:sign_in, :sign_out, :session]
  resources :articles

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
