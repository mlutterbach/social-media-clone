Rails.application.routes.draw do
  devise_for :users
  root to: 'tweets#home'
  get 'about', to: 'tweets#about'
  get 'contact', to: 'tweets#contact'
  resources :users, only: [:create, :index, :destroy] do
    resources :tweets, only: [:index, :new, :create, :edit, :update, :show]
  end
  resources :tweets, only: [:destroy]
end
