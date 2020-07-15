Rails.application.routes.draw do
  root "items#index"
  resources :items, only: [:index, :show]
  resources :orders, only: [:index, :show, :new, :create]
  resources :cart_items, only: [:index, :create, :update, :destroy]
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

  namespace :admin do
    root "items#index"
    get :login, to: 'sessions#new'
    resource :session, only: [:create, :destroy]
    resources :items
    resources :charges
    resources :delivery_periods
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :admins
  end
end
