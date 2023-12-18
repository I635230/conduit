Rails.application.routes.draw do
  root 'articles#index'
  get '/register', to: 'users#new'
  get '/profile/:username', to: 'users#show', as: 'profile'
  post '/register', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/article/:slug', to: 'articles#show', as: 'article'
  get '/editor', to: 'articles#new'
  post '/article', to: 'articles#create'
  get '/editor/:slug', to: 'articles#edit', as: 'edit_article'
  patch '/article/:slug', to: 'articles#update'
end
