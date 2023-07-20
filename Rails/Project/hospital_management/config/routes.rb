Rails.application.routes.draw do

  devise_for :patients
  devise_for :doctors
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # get 'doctors/sign_up', to: 'devise/registrations#new'
  # Defines the root path route ("/")
  root "appointments#main"
  resources :appointments
  get 'appointments/show', to: 'appointments#show'
end
