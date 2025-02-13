Rails.application.routes.draw do
  resources :brews, only: %i[index show create update destroy]
  resources :beans, only: %i[index show create update destroy]
  resources :users, only: %i[create update destroy]
  post '/auth/login', to: 'auth#login'
  get 'me', to: 'users#me'
end
