Rails.application.routes.draw do
  resources :users, except: %i[ show update destroy ]
  get 'user/profile', to:'users#show'
  post 'user/update', to:'users#update'
  post 'user/delete', to:'users#destroy'
  post 'auth/login', to: 'authentication#login'
  post  'auth/logout', to: 'authentication#logout'

  post 'todo/create', to:'todos#create'

  get '/*a', to: 'application#not_found'
end

