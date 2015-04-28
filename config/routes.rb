Rails.application.routes.draw do
  authenticated :user do
    root :to => "dashboard#index", :as => "authenticated_root"
  end
  
  root 'welcome#index'
  
  # Devise routes we skip the registration routes and them recreate them manually
  # leaving out edit and update as those are implemented in the users controller
  devise_for :users, controllers: {registrations: 'users'}
  
  # Route for user to generate a reset password email
  # For security I have disallowed users from changing their password
  # directly on the profile page. They must click this link which will send them
  # an email with a password reset token. This is to increase security so that if
  # a user left their session up no one can just go to account page and change their 
  # password, they must also have access to the users email address.
  devise_scope :user do
    post 'users/password/reset', to: 'users#password_reset', as: :reset_user_password
  end
end
