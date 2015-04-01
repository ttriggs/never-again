Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => :registrations }
  root 'restaurants#index'
  resources :restaurants do
    resources :reviews, only: [:new, :create]
  end
  resources :reviews, only: [:edit, :update, :destroy]

  resources :users, only: [:show]
end
