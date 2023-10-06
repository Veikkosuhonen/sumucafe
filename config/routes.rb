Rails.application.routes.draw do
  resources :locations
  resources :ratings
  resources :users
  resources :menu_items
  resources :meals
  resources :restaurants

  resource :session, only: [:new, :create, :destroy]

  resource :update_jobs, only: [:new, :create]

  root "restaurants#index"

  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
