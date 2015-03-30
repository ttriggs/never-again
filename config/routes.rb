Rails.application.routes.draw do
  devise_for :users
  root 'restaurants#index'
  resources :restaurants, only: [:new, :index, :show, :create ] do
    resources :reviews, only: [:new, :create]
  end

end
