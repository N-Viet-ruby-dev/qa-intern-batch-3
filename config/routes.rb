Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  root "home#index"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users do
    resources :posts, on: :member
  end

  resources :posts do
    get "/show-post", to: "posts#show_post_home"
  end

  resources :tags
  resources :comments, on: :create

  namespace :admin do
    root "dashboard#index"
    resources :categories, except: :show
    resources :users, except: [:edit, :show]
    resources :tags
  end

  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
end
