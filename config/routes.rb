Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount ActionCable.server => '/cable'
  resources :blogs do
    resources :comments
  end  
  devise_for :users
  devise_scope :user do
    root to: "devise/sessions#new"
  end  
  get "search", to: 'blogs#search'
  post "search", to: 'blogs#search'
  get "up" => "rails/health#show", as: :rails_health_check
end
