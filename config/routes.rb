Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: 'tweets#index'
  get 'about', to: 'pages#about'

  resources :users, only: [:create, :index, :destroy, :show] do
    member do
      post :follow
      delete :unfollow
    end
    resources :tweets, only: [:new, :create, :show]
  end
  resources :tweets, only: [:destroy]

  resources :tweets do
    member do
      post :retweet
    end
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
end
