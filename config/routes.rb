Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  resources :rooms do
    resources :games
    resources :players do
      post 'triggle_hidden', on: :member
    end

    resources :roles, only: [:show] do
      post 'bash_update', on: :collection
    end

    member do
      get 'control'
      post 'join'
      post 'left'
    end
  end
  
  resources :records
end
