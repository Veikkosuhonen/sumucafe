Rails.application.routes.draw do
  resources :meal_types
  resources :locations
  resources :ratings
  resources :users do
    get :password_reset, on: :member
  end
  resources :menu_items
  resources :meals do
    resources :ratings
    get :user_rating, on: :member, controller: :ratings
  end
  resources :restaurants

  resource :session, only: [:new, :create, :destroy]

  resources :password_resets, only: [:new, :create, :edit, :update]

  resource :update_jobs, only: [:new, :create]

  root "restaurants#index"

  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
