Rails.application.routes.draw do
  resources :users, except: %i[ show ]
  get 'user-profile', to:'users#show'
  post 'auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
end

