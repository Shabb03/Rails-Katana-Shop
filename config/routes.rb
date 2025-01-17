Rails.application.routes.draw do
  root 'products#index'

  namespace :admin do
    resources :products, except: [:show]
    resources :categories, except: [:show]
    delete "/logout", to: "sessions#destroy"
  end

  resources :products, only: [:index, :show] do
    member do
      post :add_to_cart
    end
  end

  namespace :users do
    resources :categories, only: [:index, :show]
    resource :cart, only: [:show, :update, :edit] do
      post 'checkout', on: :member
      delete :remove_from_cart, path: "remove/:id"
    end
    resources :orders, only: [:index, :show] do
      resources :order_items, only: [:index, :show]
    end
    post "/checkout", to: "orders#checkout"
  end

  resources :products, only: [:show] do
    member do
      post :add_to_cart
    end
  end
  post "/add_to_cart/:product_id", to: "carts#add_to_cart", as: :add_to_cart

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get "/admin/login", to: "admin/sessions#adminlogin"
  post "/admin/login", to: "admin/sessions#create"

  match '*path', to: redirect('/404.html'), via: :all
end