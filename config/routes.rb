Rails.application.routes.draw do
  resources :blogs
  devise_for :users
  root 'blogs#index'
  get "up" => "rails/health#show", as: :rails_health_check
end
