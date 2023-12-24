Rails.application.routes.draw do
  root "articles#index"

  get "/register", to: "users#new"
  post "/register", to: "users#create"
  get "/profile/:username", to: "users#show", as: "profile"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :articles, path: "article", param: :slug, only: [:show, :create, :update, :destroy]
  get "editor", to: "articles#new", as: "new_article"
  get "editor/:slug", to: "articles#edit", as: "edit_article"
end
