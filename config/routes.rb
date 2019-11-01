Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
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
      get 'users'
      get 'chart'
      post 'destroy_protect'
    end

    resources :games, only: [:edit, :update, :destroy, :index, :create]
    resources :players do
      post 'triggle_hidden', on: :member
    end
  end
end
