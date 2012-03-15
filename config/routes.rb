Linkbib::Application.routes.draw do

  devise_for :users

  get "links/new"

  get "links/create"

  get "links/index"
  
  resources :links
  resources :users
  
  root :to => 'pages#home'

end
