Rails.application.routes.draw do
  # get 'search/index'

  devise_for :admins

  # get 'search', to 'searches#index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # get 'admins', to: 'devise/registrations#new'

  root "products#index"

  get "help", to: "help#help"
  
  get "users/sign_up"

  get "sessions/sign_in"

  post "sessions/sign_in", to: "sessions#create"

  delete 'sessions/sign_out', to: "sessions#destroy"
  # delete 'products/delete', to: 'products#destroy'

  resources :users

  # resources :sessions

  resources :products

end