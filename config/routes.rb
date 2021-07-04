Rails.application.routes.draw do
  resources :users
  post '/users/confirmation_user', to: 'users#confirmation_user'
  post '/users/forgot_password', to: 'users#forgot_password'
  post '/users/reset_password', to: 'users#reset_password'
  post '/auth/login', to: 'authentication#login'
  post '/auth/google', to: 'authentication#login_google'
  post '/auth/facebook', to: 'authentication#login_facebook'
  get '/*a', to: 'application#not_found'
end
