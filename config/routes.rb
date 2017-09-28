Rails.application.routes.draw do
  get 'sessions/new'

  resources :books
  resources :users, except: [:new, :create]

  root to: 'home#index'
  get '/contact', to: 'home#contact', as: 'contact'

  get '/signup', to: 'users#new', as: 'new_user'
  post '/signup', to: 'users#create'

  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  delete 'signout', to: 'sessions#destroy'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end