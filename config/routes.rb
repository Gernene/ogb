Rails.application.routes.draw do
  root   'static_pages#home'
  get    '/help',    to: 'static_pages#help'
  get    '/about',   to: 'static_pages#about'
  get    '/contact', to: 'static_pages#contact'
  get    '/signup',  to: 'users#new'
  post   '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get    '/search',   to: 'posts#search'
  get    '/myposts',  to: 'posts#myposts'
  get    '/newpost',  to: 'posts#new'
  post   '/newpost',  to: 'posts#create'
  get '/mycommitments', to: 'requests#commitments'
  
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :posts,          only: [:create, :destroy, :show]
  resources :requests,          only: [:create, :destroy, :show, :update]
end