Rails.application.routes.draw do
  resources :books
  resources :users

  root to: 'home#index'
  get '/contact', to: 'home#contact', as: 'contact'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
