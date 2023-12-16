Rails.application.routes.draw do
  get '/register', to: 'users#new'
  get '/profile/:username', to: 'users#show', as: 'profile'
  post '/register', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
