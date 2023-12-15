Rails.application.routes.draw do
  get '/register', to: 'users#new'
  get '/profile/:username', to: 'users#show'
  post '/register', to: 'users#create'  
end
