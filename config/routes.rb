Rails.application.routes.draw do
  devise_for :admin_users, :users
  resources :books, :comments

  resources :books do
    resources :comments
    resources :likes, only: [:new, :create, :destroy]
    resources :book_histories, only: [:index]
  end

  root to: 'books#index'
  get 'user/index', to: 'users#index'
end
