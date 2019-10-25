Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  resources :rooms do
    resources :games
    resources :players do
      member do
        post 'triggle_hidden'
      end
    end
    member do
      get 'control'
    end
  end
  
  resources :records
end
