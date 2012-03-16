Linkbib::Application.routes.draw do

  get "passthrough/index"

  devise_for :users

  get "links/new"

  get "links/create"

  get "links/index"
  
  resources :links
  resources :users
  
  match "/home" => 'pages#home'
  
  root :to => 'passthrough#index'


end
