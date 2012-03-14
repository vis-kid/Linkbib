Linkbib::Application.routes.draw do
  get "links/new"

  get "links/create"

  get "links/index"
  
  resources :links

end
