Rails.application.routes.draw do
  root "hello#index"

  devise_for :users

  resources :users

  get "/articles", to: "articles#index"

  resources :orders do 
    get 'approve', on: :member
    get 'perform_order', on: :member
    get 'check', on: :collection
    get 'make_report', on: :collection
  end
end

