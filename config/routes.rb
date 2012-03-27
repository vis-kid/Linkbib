Linkbib::Application.routes.draw do

  get "passthrough/index"

  devise_for :users 

  get "links/new"

  get "links/create"

  get "links/index"
  
  resources :links
  
  resources :relationships
  
  resources :users do
    member do
      get :following, :followers
    end
  end
  
  root :to => 'pages#home'
  
  get "/:id", :to => "users#show", :as => :user

end
