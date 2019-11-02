Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'rooms#index'

  resources :rooms do
    collection do
      get 'join'
      post 'verify'
      post 'sample'
    end

    member do
      post 'left'
      get 'chart'
    end

    resources :games, only: [:edit, :update, :destroy, :index, :create]
    resources :players do
      post 'triggle_hidden', on: :member
    end
  end

  namespace :api do
    post 'line_callback', to: 'line_callback#index'
  end
end
