Rails.application.routes.draw do
  root 'articles#index'

  get '/register', to: 'users#new'
  get '/profile/:username', to: 'users#show', as: 'profile'
  post '/register', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'


  resources :articles, path: 'editor', param: :slug, only: [:new, :edit]
  # get '/editor', to: 'articles#new'
  # get '/editor/:slug', to: 'articles#edit', as: 'edit_article'


  resources :articles, path: 'article', param: :slug, only: [:show, :create, :update, :destroy]
  # get '/article/:slug', to: 'articles#show', as: 'article'
  # post '/article', to: 'articles#create', as: 'create_article'
  # patch '/article/:slug', to: 'articles#update', as: 'update_article'
  # delete '/article/:slug', to: 'articles#destroy', as: 'destroy_article'
end
