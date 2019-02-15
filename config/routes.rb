Rails.application.routes.draw do
  devise_for :admin_users
  devise_for :users
  resources :books, :comments, :users
  resources :registers, except: [:show, :edit, :update]

  resources :books do
    member do
      patch :take, :return
      put :take, :return
    end

    resources :comments
    resources :likes, only: [:new, :create, :destroy]
  end

  match 'books/:id', to: 'books#show', via: [:get, :post]
  root to: 'books#index'
  get 'user/index', to: 'users#index'
end
