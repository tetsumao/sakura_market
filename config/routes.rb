Rails.application.routes.draw do
  root "diaries#index"
  resources :items, only: [:index, :show]
  resources :orders, only: [:index, :show, :new, :create] do
    collection do
      post :confirm
    end
  end
  resources :cart_items, only: [:index, :create, :update, :destroy]
  resources :diaries, only: [:show, :create] do
    resources :goods, only: [:create, :destroy]
    collection do
      post :gooded_users
    end
  end
  resources :comments, only: [:create] do
    collection do
      post :switch
    end
  end
  resources :coupons, only: [:index, :create]
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
    resources :coupons
    resources :admins
  end
end
