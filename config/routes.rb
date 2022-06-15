Rails.application.routes.draw do
  resources :users, except: %i[ show update destroy ]
  get 'user/profile', to:'users#show'
  post 'user/update', to:'users#update'
  post 'user/delete', to:'users#destroy'
  post 'auth/login', to: 'authentication#login'
  get  'auth/logout', to: 'authentication#logout'
  get '/*a', to: 'application#not_found'
end

