Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: :registrations }
  root 'restaurants#index'
  resources :restaurants do
    resources :reviews, only: [:show, :new, :create, :edit, :update]
  end
  resources :users, only: [:show]
  resources :reviews, only: [:destroy]

  namespace :admin do
    resources :users, only: [:index, :destroy]
    resources :reviews, only: [:destroy]
    resources :restaurants, only: [:destroy]
  end
end
