Rails.application.routes.draw do
  root to: 'users#home'
  get 'about', to: 'users#about'
  get 'contact', to: 'users#contact'
  resources :users
end
