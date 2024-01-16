Rails.application.routes.draw do
  resources :blogs do
    resources :comments
  end
  devise_for :users
  devise_scope :user do
    root to: "devise/sessions#new"
  end  
  get "up" => "rails/health#show", as: :rails_health_check
end
