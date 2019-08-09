Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  get 'password_resets/new'
  get 'password_resets/edit'
  root "home#index"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users do
    resources :posts, on: :member
  end

  resources :tags

  namespace :admin do
    root "dashboard#index"
    resources :categories, except: :show
    resources :users, except: [:edit, :show]
    resources :tags
    resources :posts
  end

  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
end
