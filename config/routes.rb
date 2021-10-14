Rails.application.routes.draw do

  devise_for :users

  get 'persons/profile'
  
  namespace :admin do
    root 'welcomes#index'
  end

  root 'orders#calc'

  resources :orders, :users

  resources :orders, only: [:index , :show]

  resources :users do
    resources :orders, except: [:destroy, :edit, :update]
  end

  resources :orders do 
   get 'approve', on: :member
  end


  get "/articles", to: "articles#index"

  get "/hello/index"

  get 'persons/profile', as: 'user_root'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

