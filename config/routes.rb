Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: 'tweets#index'
  get 'about', to: 'tweets#about'
  get 'contact', to: 'tweets#contact'
  resources :users, only: [:create, :index, :destroy, :show] do
    resources :tweets, only: [:index, :new, :create, :edit, :update, :show]
  end
  resources :tweets, only: [:destroy]

  resources :tweets do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
end
