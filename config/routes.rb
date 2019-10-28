Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'rooms#index'

  resources :rooms do
    member do
      get 'control'
      get 'password'
    end

    collection do
      get 'like'
      get 'join'
      post 'verify'
    end

    resources :games, only: [:edit, :update, :destroy]
    resources :players do
      post 'triggle_hidden', on: :member
    end

    resources :roles, only: [:show] do
      collection do
        post 'join'
        post 'left'
        post 'bash_update'
      end
    end
  end
  
  resources :records, only: :create
end
