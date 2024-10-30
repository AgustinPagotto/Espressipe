Rails.application.routes.draw do
  resources :users, only: %i[create update destroy]
  post '/auth/login', to: 'auth#login'
  get 'me', to: 'users#me'
end
