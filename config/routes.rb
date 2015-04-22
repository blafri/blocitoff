Rails.application.routes.draw do
  authenticated :user do
    root :to => "dashboard#index", :as => "authenticated_root"
  end
  
  root 'welcome#index'
  resource :user, only: [:edit, :update]
  
  # Route for users to send reset password email from their 
  # account settings page. They need to do this to change
  # their password
  post '/user', to: 'users#reset_password'
  
  # Devise routes we skip the registration routes and them recreate them manually
  # leaving out edit and update as those are implemented in the users controller
  devise_for :users, skip: :registrations
  devise_scope :user do
    get '/users/cancel', to: 'devise/registrations#cancel', as: :cancel_user_registration
    post '/users', to: 'devise/registrations#create', as: :user_registration
    get '/users/sign_up', to: 'devise/registrations#new', as: :new_user_registration
    delete '/users', to: 'devise/registrations#destroy'
  end
end
