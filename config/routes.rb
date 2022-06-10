Rails.application.routes.draw do
  resources :users, except: %i[ show update ]
  get 'user/profile', to:'users#show'
  post 'user/update', to:'users#update'
  post 'auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
end

