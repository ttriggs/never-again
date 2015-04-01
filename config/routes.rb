Rails.application.routes.draw do
  devise_for :users
  root 'restaurants#index'
  resources :restaurants do
    resources :reviews, only: [:show, :new, :create, :edit, :update]
  end
  resources :reviews, only: [:destroy]
end
