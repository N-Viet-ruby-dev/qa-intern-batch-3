Rails.application.routes.draw do
  root "home#index"

  get "/signup", to: "users#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users do
    resources :posts, on: :member
  end
  resources :tags
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

  namespace :admin do
    root "dashboard#index"
    resources :categories, except: :show
    resources :users, except: [:edit, :show]
    resources :tags
  end
end
