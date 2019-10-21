Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  resources :rooms
  resources :players do
    member do
      post 'triggle_hidden'
    end
  end
  resources :games
  resources :records
end
