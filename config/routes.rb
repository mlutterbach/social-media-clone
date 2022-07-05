Rails.application.routes.draw do
  devise_for :users
  root to: 'tweets#home'
  get 'about', to: 'tweets#about'
  get 'contact', to: 'tweets#contact'
  resources :users, only: [:create, :index, :destroy] do
    resources :tweets
  end
end
