Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: :registrations }
  root 'homes#index'
  resources :restaurants do
    resources :reviews, only: [:show, :new, :create, :edit, :update]
    resources :upvotes, only: :create
    resources :downvotes, only: :create
  end
  resources :users, only: [:show]
  resources :reviews, only: [:destroy]
end
