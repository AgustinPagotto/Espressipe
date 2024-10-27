Rails.application.routes.draw do
  resources :users, only: %i[index show create update destroy]
  get '/login', to: 'session#new'
  post '/login', to: 'session#create'
  delete '/logout', to: 'session#destroy'
end
