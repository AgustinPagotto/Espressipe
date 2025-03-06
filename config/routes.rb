Rails.application.routes.draw do
  resources :beans, only: %i[index show create update destroy] do
    resources :brews, only: %i[index show create update destroy]
  end
  get 'users/brews', to: 'brews#user_brews'
  resources :users, only: %i[create update destroy]
  post '/auth/login', to: 'auth#login'
  get 'me', to: 'users#me'
end
